
# Netflix Clone

Netflix clone is a project based on Swift 5 , where a user view Trending Movies , Trending Shows , Popular Movies , Upcoming Movies in Home View. Also he can watch & download movies & tv shows.

## Features

- Using TMDB to fetch Movie APIs
- Using YouTube API to show movie trailer
- Dark mode enabled in App
- Use SdWebImage package to set images for URL
- Use Gradient Layer in Header of Movies


## API Reference

#### Get Trending Movies

```http
  GET https://api.themoviedb.org/3/trending/movie/day?api_key=<<api_key>>
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get Trending Tv Shows

```http
  GET https://api.themoviedb.org/3/trending/tv/day?api_key=<<api_key>>
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get Upcoming Movies

```http
  GET https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get Popular Movies/Shows

```http
  GET https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get Top Rated Movies/Shows

```http
  GET https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |
