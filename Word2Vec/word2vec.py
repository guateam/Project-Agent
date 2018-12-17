import logging

from gensim import models

MODEL_PATH = '../Word2Vec/word2vec.model'


def word2vec():
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    model = models.Word2Vec.load(MODEL_PATH)
    vector=model.wv
    vector.save_word2vec_format('word2vec.tsv')


def word2vec_similarity(word1, word2):
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    model = models.Word2Vec.load(MODEL_PATH)
    return model.similarity(word1, word2)


def word2vec_tag_recommend(words, wordlist, num):
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    model = models.Word2Vec.load(MODEL_PATH)
    recommend_list = [];
    for word in words:
        for value in wordlist:
            if value['name'] in model:
                if word['name'] in model:
                    if value['name'] != word['name']:
                        recommend_list.append({
                            'name': value['name'],
                            'weight': float(model.similarity(word['name'], value['name']))
                        })
    recommend_list = sorted(recommend_list, key=lambda word: word['weight'], reverse=True)
    tag_list = []
    for value in recommend_list:
        flag = True
        for tag in tag_list:
            if tag['name'] == value['name']:
                flag = False
        if flag:
            tag_list.append(value)
    tag_list = sorted(tag_list, key=lambda word: word['weight'], reverse=True)
    while len(tag_list) > num:
        tag_list.pop()
    return tag_list


if __name__ == "__main__":
    word2vec()
