module lemmatize {
    
    # Constructing the hash table for our lemmas
    my %lemma_hash;
    our sub construct_hash($filename) is export {
        # import the lemmas in the csv file and push each line to an array
        my @lemma_lines = [];
        for $filename.IO.lines -> $line {
            @lemma_lines.push($line); 
        }
        
        # for each line in @lemma_lines: trim whitespace, clear quotation marks and commas, and separate on remaining spaces
        # these separated values are then appended to @temp_array, which is appended to @perm_array as our master array of arrays
        my @perm_array;
        for @lemma_lines {
            my @temp_array;
            my $line = $_;
            for $line.words {
                # trim whitespace
                my $temp_string = trim($_);
                # clear quotation marks and commas
                my $temp_string_2 = $temp_string.comb:  / <-[",]>+ | <["]> ~ <["]>  <-["]>+ / ;
                # split on blank spaces and append each value to our array
                for split(" ", $temp_string_2).Str {
                    for split(" ", $_) {
                        @temp_array.push($_);
                    }
                }
            }
            @perm_array.push(@temp_array);
        }
        
        # iterate through each array in @perm_array and append the first value as a key for the remaining values in the array
        for @perm_array {
            my @cur_array = $_;
            for @cur_array {
            # pushing the first element in the array to the key and the rest to the values
                %lemma_hash.push(%($_[0],$_[1..*]));
            }
        }
        return %lemma_hash;
    };

    # A subroutine to append the words in a string to an array of words, cleaning out punctuation and setting all to lowercase
    our @words_in_string;
    our sub words_to_array($sent_) is export {
        my @array_of_words;
        # setting the array to empty to erase past values
        @words_in_string = ();
        # iterating through the string's words, lowercasing each value, and removing punctuation
        for $sent_.words {
            my $cur_word = $_.lc;
            for $cur_word {
            # split on apostrophe to get conjunctions
            for $cur_word.split("'") {
                    my $no_punct_word = S:g /<:punct>//;
                    @words_in_string.push($no_punct_word);
            }
            }
        }
        return @words_in_string;
    };
   
   # lemmatize each word in a given array by comparing it to our %lemma_hash
   our sub lemmatize_array(@array_to_lemmatize) is export {
        # the array to append our lemmatized words to
        my @lemmatized_sentence;
        # keeping track of the index so we can iterate through the hash table to check each word
        my $cur_index = 0;
        # iterate through our hash values and the words in our array
        for %lemma_hash.values -> @array_vals {
                for @array_to_lemmatize {
                    my $cur_word = $_.lc;
                    # check if the current word in our array matches any value for the hash's current key
                    # if it matches the key is pushed to our array, and if it doesn't the word is pushed as is
                    if grep $cur_word, @array_vals {
                        my $key_to_push = %lemma_hash.keys[$cur_index];
                        @lemmatized_sentence.push($key_to_push);
                            }
                    else {
                        @lemmatized_sentence.push($cur_word);
                    }
                    }
                    # set our array to the version we just created, which preserves word order and values we've already lemmatized
                    @array_to_lemmatize = @lemmatized_sentence;
                    # set the array to empty to avoid duplicate entries 
                    @lemmatized_sentence = ();
                    # increment the index to proceed through @array_vals
                    ++$cur_index;
        }

        return @array_to_lemmatize;
    };
    
    # a subroutine to lemmatize a string, which uses the functions above to convert the string into an array before lemmatizing
    our sub lemmatize_string($string_to_lemmatize) is export {
        my @array_to_lemma = words_to_array($string_to_lemmatize);
        my @lemmaed = lemmatize_array(@array_to_lemma);
        return @lemmaed;
    };
};
