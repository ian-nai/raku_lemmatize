
# Raku Lemmatize
A Raku module to lemmatize strings and lists, with support for 24 languages.

## Installation
Install using zef:
```
zef install lemmatize
```
Or simply download the GitHub repo.

## Usage
The package uses csv files containing predefined lemmas in a two column format, with the lemma on the left and its derivatives on the right. Any similarly formatted .csv can be used to run the code, allowing for easy use of custom lemma lists
and additional languages.

The following four subroutines can be called:

To construct your hash table of lemma pairs; this must be done before lemmatizing:
```
construct_hash('resources/en.csv');
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

## Supported Languages and Their Codes

The following languages are included in the package, and their lemma pairs are stored in csv files titled with their language codes (e.g., 'ast.csv').

* Asturian - ast
* Bulgarian - bg
* Catalan - ca
* Czech - cs
* English - en
* Estonian - et
* French - fr
* Galician - gl
* German - de 
* Hungarian - hu
* Irish - ga
* Manx Gaelic - gv
* Italian - it
* Persian/Farsi - fa
* Portuguese - pt
* Romanian - ro
* Russian - ru
* Scottish Gaelic - gd
* Slovak - sk
* Slovene - sl
* Spanish - es
* Swedish - sv
* Ukrainian - uk
* Welsh - cy


## Lemma List and Formatting
### Source
The list of English lemmas included here was sourced from [this GitHub repo](https://github.com/skywind3000/lemma.en) by [Lin Wei.](https://github.com/skywind3000), and the other languages were sourced from [this GitHub repo](https://github.com/michmech/lemmatization-lists) by [Michal Měchura.](https://github.com/michmech), then converted into csvs for inclusion here.


### Formatting
To create your own list of lemmas for use with the library, create a csv file formatted like the one included here. Use two columns, the first containing your lemmas and the second containing comma-separated forms of the lemmas. 
