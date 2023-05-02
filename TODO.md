## TODO List

- [ ] Combine Set-HDDSize and Set-RAMSize. Implement a single function named, for example, Set-AttributeSize, that combines Set-HDDSize and Set-RAMSize.
- [ ] Replace all occurrences of "Lenght" with "Count" but make sure there are no adverse effects. In PowerShell, the Count property is generally preferred over Length to obtain the number of elements in a collection. Count is specific to certain collections like arrays, lists, and dictionaries, and it is more efficient in terms of performance compared to Length. Length is primarily used for strings, arrays of characters, and multidimensional arrays and may require additional computation, slightly reducing performance.
- [ ] Add relevant comments in the code to explain the logic and important steps.
- [ ] Create a function to automatically detect the prefix (srv for server, cli for client) when naming VMs.
- [ ] Improve the logic of the scope of variables (global and local). Some global variables might not need such a scope with some optimizations.
