## `get_cwd`

```ab
pub fun get_cwd(): Text 
```

Get current working directory


## `get_directory_entries`

```ab
pub fun get_directory_entries(path: Text): [Text] 
```

Get directory entries as array of "name\ttype" strings
type: "d" for directory, "f" for file


## `get_parent_dir`

```ab
pub fun get_parent_dir(path: Text): Text 
```

Get parent directory


## `is_directory`

```ab
pub fun is_directory(path: Text): Bool 
```

Check if path is a directory


## `normalize_path`

```ab
pub fun normalize_path(path: Text): Text 
```

Normalize a path (resolve .. and .)


## `parse_entry`

```ab
pub fun parse_entry(entry: Text): [Text] 
```

Parse entry string into [name, type, target]


## `path_join`

```ab
pub fun path_join(base: Text, child: Text): Text 
```

Join two path components


