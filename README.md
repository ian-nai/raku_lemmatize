
# Raku Lemmatize
A Raku module to lemmatize strings and lists.

## Installation
Install using zef:
```
zef install lemmatize
```
Or simply download the GitHub repo.

## Usage
The package uses a .csv containing predefined English lemmas in a two column format, with the lemma on the left and its derivatives on the right. Any similarly formatted .csv can be used to run the code, allowing for easy use of custom lemma lists
and non-English languages.

The following four subroutines can be called:

To construct your hash table of lemma pairs; this must be done before lemmatizing:
```
construct_hash('resources/lemmas.csv');
# or substitute your own filename in place of 'lemmas.csv'
```

To lemmatize a string (which also converts every character in the string to lowercase):
```
lemmatize_string($your_string);
```

To lemmatize an array of words (which also converts every string in the list to lowercase):
```
lemmatize_array(@your_array);
```

To convert a string to an array of its component words:
```
words_to_array($your_string);
```

## Lemma List and Formatting
### Source
The list of lemmas included here was sourced from [this GitHub repo](https://github.com/skywind3000/lemma.en) by [Lin Wei.](https://github.com/skywind3000) 

The list was created by referencing the British Nation Corpus (BNC), NodeBox Linguistics and Yasumasa Someya's lemma list.
From the original repo:
>This lemma list is provided "as is" and is free to use for any research and/or educational purposes. The list currently contains 186,523 words (tokens) in 84,487 lemma groups.

### Formatting
To create your own list of lemmas for use with the library, create a csv file formatted like the one included here. Use two columns, the first containing your lemmas and the second containing comma-separated forms of the lemmas. 

