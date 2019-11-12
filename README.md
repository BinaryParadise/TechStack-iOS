# iOS入门指南

iOS重要知识点介绍、演示
在线阅读：[https://binaryparadise.gitbook.io/objective-c](https://binaryparadise.gitbook.io/objective-c)

## Demo目录

> Examples/*

## 沙盒环境自动续订

- 最多产生6笔订单，完成后可以删除App再测试自定订阅
- 自动续订成功后，关掉App，超过持续时间时打开App，看能否自动续订

| 实际持续时间 |  沙箱持续时间 |
| --- | --- |
| 1 week   | 3 minutes |
| 1 month  | 5 minutes |
| 2 months | 10 minutes |
| 3 months | 15 minutes |
| 6 months | 30 minutes |
| 1 year   | 1 hour|
