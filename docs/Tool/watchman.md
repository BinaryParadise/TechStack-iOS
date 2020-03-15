# watchman

## 安装

```bash
brew install watchman
```

## 使用

```bash
#监听一个目录
watchman watch ~/Github/MyDir
```

```bash
#使用触发器(工作目录是监控目录)
watchman -- trigger DataSource 'ex-trigger' -- ruby ./extractor.rb
```

