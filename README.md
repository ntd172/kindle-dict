## TLDR;

1. Just download `eng-viet-dict.mobi` file and send it to your kindle email `<user.name>@kindle.com`!
2. Wait for your kindle to download the dictionary file. 
3. Change your default dictionary to `English-Viet-Dictionary`.

# English Vietnamese Dictionary for Kindle #

Last year, I received a Amazon Kindle PaperWhite as a gift. Since then, I've been reading more books from my Kindle. 
By default the Kindle does come with few popular dictionaries from English to Chinese, Spanish, French... 
but I was a little disappointed because there is no English-Vietnamese dictionary. So I tried to find a English-Vietnamese
dictionary. Unfortunately, I have found none. Then I decided to create my own English-to-Vietnamese dictionary for the Kindle.

## Getting Started

These instructions will help you to create your own dictionary for Amazon Kindle. Feel free to modify 
and change the code to fit your needs.

### Prerequisites
  
- Install ```KindleGen``` from `Amazon`
```
https://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000234621
```

- Add `kindlegen` to your `$PATH`
- Make sure you install `calibre` application for your `MacOSX` 
```
https://calibre-ebook.com/download
``` 

### Installing
If you don't care about any technical stuff, just ignore and import `eng-viet-dict.mobi` to your `calibre` app or email this 
file to kindle email `<username>@kindle.com`


Otherwise, you can take a look at `build_dict.sh` to see how I generate that file. 

```
./build_dict.sh 

```

### Limitation

Initially I tried to import all words and definition from `startdict_en_vi.txt` (~350K words).
`KindleGen` was not able to handle that much of data so I needed to reduce the number of words to import. 

I used this awk to get common words from `dictionary.txt` file. 
```
awk -F\t 'FNR==NR {a[$1]; next}; $1 in a' dictionary.txt stardict_en_vi.txt > common-english-viet-words.txt

```

### Happy Reading

![Alt text](example.png?raw=true "Sample Page")

