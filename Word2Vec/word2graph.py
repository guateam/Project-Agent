
from tqdm import tqdm # progression bars
import numpy as np
with open('word2vec.vec','r',encoding='utf-8') as f:
    header = f.readline()
    vocab_size, vector_size = map(int, header.split())
    words, embeddings = [], []
    for line in tqdm(range(vocab_size)):
        word_list = f.readline().split(' ')
        word = word_list[0]
        vector = word_list[1:-1]
        words.append(word)
        embeddings.append(np.array(vector))

import tensorflow as tf
from tensorflow.contrib.tensorboard.plugins import projector
import os

log_path = 'logs'
with tf.Session() as sess:
    # tf.assign():这里是一个将具体数值（即，词向量矩阵）赋值给tf Variable的例子：
    X = tf.Variable([0.0], name='embedding')
    place = tf.placeholder(tf.float32, shape=[len(words), vector_size-1])
    set_x = tf.assign(X, place, validate_shape=False)
    sess.run(tf.global_variables_initializer())
    sess.run(set_x, feed_dict={place: embeddings})

    # 需要保存一个metadata文件,给词典里每一个词分配一个身份
    with open('./graph.tsv', 'w',encoding='utf-8') as f:
        for word in tqdm(words):
            f.write(word + '\n')

    # 写 TensorFlow summary
    summary_writer = tf.summary.FileWriter(log_path, sess.graph)
    config = projector.ProjectorConfig()
    embedding_conf = config.embeddings.add()
    embedding_conf.tensor_name = 'embedding:0'
    embedding_conf.metadata_path ='./graph.tsv'
    projector.visualize_embeddings(summary_writer, config)

    # 保存模型
    # word2vec参数的单词和词向量部分分别保存到了metadata和ckpt文件里面
    saver = tf.train.Saver()
    saver.save(sess, "./model.ckpt")