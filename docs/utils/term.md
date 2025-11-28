## `get_term_size`

```ab
fun get_term_size(): Null ? 
```

Get the terminal size (columns, rows) using ANSI escape sequence.


## `stty_lock`

```ab
pub fun stty_lock(): Null 
```

Lock the terminal (disable echo). Uses reference counting via environment variable.


## `stty_unlock`

```ab
pub fun stty_unlock(): Null 
```

Unlock the terminal (enable echo). Uses reference counting via environment variable.


## `term_height`

```ab
pub fun term_height(): Num 
```

Get the terminal height (rows).


## `term_size`

```ab
pub fun term_size(): [Num] 
```
## `term_width`

```ab
pub fun term_width(): Num 
```

Get the terminal width (columns).


