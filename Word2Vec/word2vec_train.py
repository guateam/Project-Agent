import os

from gensim import models
from gensim.models import word2vec
import logging


def word2vec_train():
    jieba_path = './wiki_text/wiki_jieba_text.txt'
    model_path = './word2vec.model'

    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    sentences = word2vec.LineSentence(jieba_path)
    model = word2vec.Word2Vec(sentences, size=250)
    model.save(model_path)


def word2vec_extra_train(extra_path):
    model_path = './word2vec.model'
    if not os.path.exists(extra_path):
        print('找不到文件！')
        return False
    if not os.path.exists(model_path):
        print('找不到文件！')
        return False

    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    model = models.Word2Vec.load('word2vec.model')
    model.train(word2vec.LineSentence(extra_path))


if __name__ == "__main__":
    word2vec_train()
