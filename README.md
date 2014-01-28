sra Cookbook
============
Deploys the SRA application to a server

Requirements
------------
#### packages
- `git` - sra needs git to deploy

Attributes
----------
None, but leaving the example text here for reference in case that changes in the future.
#### sra::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sra']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### sra::default
If deploying for development, just include `sra` in your node's `run_list`
If deploying for production, include `sra::production` in the `run_list`
instead.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sra]"
  ]
}
```

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sra::production]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
MIT License
Authors: Cody Poll `<CJPoll(at)[Google's Email Service].com`
