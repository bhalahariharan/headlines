<h1 align="center"> Headlines </h1><br>

[<img src="https://img.shields.io/badge/flutter-blue?style=flat&logo=flutter" alt="Flutter">](https://flutter.dev)
[<img src="https://img.shields.io/github/license/bhalahariharan/headlines" alt="MIT">](LICENSE)

## Table of Contents

- [Introduction](#introduction)
- [Development](#development)

## Introduction

Headlines is a minimalistic news application that shows the breaking news and the latest top-headlines. Headlines uses [News API](https://newsapi.org) to fetch the news. The title and an image stating about the news is displayed in the tile along with the author and the published date. On clicking the tile, the news will be opened in the browser to read in detail about it.

<p align="center">
  <img src="https://user-images.githubusercontent.com/25824784/63775247-8e867100-c8fc-11e9-98bf-8f97c3840a6a.png" width="360">
</p>

## Development

- Clone or download the repo
- Create an API key in [News API](https://newsapi.org) (free for developers)
- In [`lib/main.dart`](lib/main.dart), place the API key for the header `X-Api-Key` in the method `fetchHeadlines`
- Run the application
