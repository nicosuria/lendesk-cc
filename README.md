# Image Analyzer
This program will scan a directory for jpg images and output its EXIF GPS information (latitude/longitude).

## Requirements
- Ruby version manager (`rbenv` or `rvm`).

## Installation

1. Install the ruby version if not already present.

```bash
rbenv install 2.5.3
```
  or 
```bash
rvm install 2.5.3
```

2. Unzip the directory and go into the project directory.

```bash
unzip -a lendesk-cc.zipp ; cd lendesk-cc
```

3. Install bundler and bundled gems.

```bash
gem install bundler ; bundle install
```

4. You should be good to go! Use the following command run your first analysis.

```bash
ruby app.rb
```

See help using the `-h` option:

```bash
ruby app.rb -h
```
## Run Tests
```bash
rspec
```
