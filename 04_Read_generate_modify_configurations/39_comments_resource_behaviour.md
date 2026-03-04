# Comments

We can use
```
# single line
// single line
/* */ multi line
```

# resource behaviour 

1) If resource is not present in state file and resource is present in config file -> resource will be created
2) If resource is present in state file and not present in config file -> resource will be destoryed
3) If resource is changed in config file, If the resource can be updated in place, The resource will be updated in place. example: tags
4) If API limitations and resource cannot be changed in place, The resource will be destoryed and recreated.



