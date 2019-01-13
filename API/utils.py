import datetime


def get_formative_datetime(old_time):
    """
    获取格式化的时间
    :param old_time: 需要格式化的datetime对象
    :return: 格式化后的时间(str)
    """
    now = datetime.datetime.now()
    # 如果时间和现在相差一天以内
    if (now - old_time).days < 1:
        # 如果已经过了0点
        if now.day > old_time.day:
            return '昨天' + old_time.strftime('%H:%M')
        else:
            return old_time.strftime('%H:%M')
    else:
        # 返回 年/月/日
        return old_time.strftime('%Y/%m/%d')
