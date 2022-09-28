# BDT-Final-Project
# Twiter covid tweet analysis BDT course project






- bdt-twitter-stream

  - kafka, download from web

  - Project_Producer

  - Project Consumer



### How to run the project



- Take the start.sh and put it inside kafaka



```
    $ cd kafka_2.13-3.1.0/

    $ ./start.sh --server localhost:9092 --topic-name twitter_tweets

```



- Import and run project Project_Producer

- Import and run Project Consumer

- Hive command



  **CREATE EXTERNAL TABLE tweets(created_at string, text string, name string, followers_count int, friends_count int, retweet_count int, reply_count int, lang string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' LOCATION '/user/cloudera home/tweets';**
