import os

from gensim.corpora import WikiCorpus


def work_for_wiki_text():
    """
    对Wiki文档进行处理
    :return:
    """
    wiki_path='./wiki_text/zhwiki-20181001-pages-articles.xml.bz2'  # 训练样本文件wiki中文提取文档
    if not os.path.exists(wiki_path):
        print('检测不到训练文件！')
        exit()
    wiki_corpus = WikiCorpus(wiki_path, dictionary={})
    texts_num = 0

    with open("./wiki_text/wiki_text.txt", 'w', encoding='utf-8') as output:
        for text in wiki_corpus.get_texts():
            output.write(' '.join(text) + '\n')
            texts_num += 1
            if texts_num%1000==0:
                print("已处理 "+str(texts_num)+'篇文章')


if __name__ == "__main__":
    work_for_wiki_text()