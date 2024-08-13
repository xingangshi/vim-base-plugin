# vim-base-plugin
vim 下常用的一些函数和命令的合集。


---

# Vim 插件开发：目录结构和注意事项

## 推荐的目录结构
```
plugin-name/
├── autoload/
│   └── pluginname.vim
├── doc/
│   └── pluginname.txt
├── plugin/
│   └── pluginname.vim
├── ftplugin/
│   └── filetype.vim
├── syntax/
│   └── syntax_name.vim
├── README.md
└── LICENSE
```
## 目录说明

1. `autoload/`: 包含延迟加载的函数。
2. `doc/`: 包含插件的文档。
3. `plugin/`: 包含在 Vim 启动时加载的脚本。
4. `ftplugin/`: 包含特定文件类型的设置。
5. `syntax/`: 包含语法高亮定义。
6. `README.md`: 项目说明文件。
7. `LICENSE`: 许可证文件。

## 注意事项

1. 命名约定：
   - 使用小写字母和下划线命名文件和函数。
   - 避免与其他插件冲突，可以使用插件名作为前缀。

2. 性能考虑：
   - 尽可能使用 `autoload` 延迟加载功能。
   - 避免在 `plugin/` 目录中放置大量代码。

3. 全局变量：
   - 使用 `g:` 前缀定义全局变量。
   - 提供用户配置选项时，检查变量是否已存在。

4. 函数定义：
   - 使用 `function!` 而不是 `function` 以允许重新加载。
   - 考虑使用 `autoload#` 前缀定义函数。

5. 映射：
   - 使用 `<Plug>` 映射允许用户自定义键绑定。
   - 提供默认映射，但允许用户禁用。

6. 自动命令：
   - 将自动命令组合在一个组中，便于清理。
   - 考虑提供禁用自动命令的选项。

7. 文档：
   - 在 `doc/` 目录中提供全面的文档。
   - 包括安装说明、使用方法和配置选项。

8. 错误处理：
   - 使用 `try`-`catch` 块处理可能的错误。
   - 提供有意义的错误消息。

9. 兼容性：
   - 考虑不同版本的 Vim 的兼容性。
   - 使用特性检测而不是版本检查。

10. 测试：
    - 考虑为你的插件编写测试。
    - 可以使用像 Vader 这样的测试框架。

11. 版本控制：
    - 使用 Git 进行版本控制。
    - 为重要的更改创建标签和版本。

12. 配置选项：
    - 为所有用户可配置的选项提供合理的默认值。
    - 在文档中清楚地说明所有配置选项。

13. 插件加载控制：
    - 在主插件文件开头添加加载控制逻辑：
    ```
    if exists('g:loaded_pluginname')
      finish
    endif
    let g:loaded_pluginname = 1
    ```

14. 尊重用户设置：
    - 不要无条件覆盖用户的设置。
    - 使用 `setlocal` 而不是 `

---

# Vim 插件基本语法

Vim 插件使用 Vimscript 语言编写。以下是 Vim 插件开发中的一些基本语法和概念：

## 1. 变量

```
let g:plugin_variable = "value"  " 全局变量
let s:script_variable = "value"  " 脚本局部变量
let b:buffer_variable = "value"  " 缓冲区局部变量
```

## 2. 函数
```
function! MyFunction(arg1, arg2)
  " 函数体
  return result
endfunction
```
## 3. 命令
```
command! MyCommand call MyFunction()
```
## 4. 映射
```
nnoremap <Leader>key :call MyFunction()<CR>
```
## 5. 自动命令
```
autocmd FileType python call SetupPythonEnvironment()
```
## 6. 条件语句
```
if condition
  " 代码
elseif other_condition
  " 代码
else
  " 代码
endif
```
## 7. 循环
```
for item in list
  " 代码
endfor

while condition
  " 代码
endwhile
```
## 8. 列表和字典
```
let my_list = ['item1', 'item2', 'item3']
let my_dict = {'key1': 'value1', 'key2': 'value2'}
```
## 9. 字符串操作
```
let joined = join(['a', 'b', 'c'], ', ')
let parts = split("a,b,c", ",")
let upper = toupper("hello")
```
## 10. 文件操作
```
let lines = readfile('filename.txt')
call writefile(lines, 'newfile.txt')
```
## 11. 缓冲区操作
```
let current_line = getline('.')
call setline('.', 'New content')
```
## 12. 窗口操作
```
let win_count = winnr('$')
execute 'wincmd w'
```
## 13. 插件加载控制
```
if exists("g:loaded_myplugin")
  finish
endif
let g:loaded_myplugin = 1
```
## 14. 选项设置
```
set tabstop=4
setlocal wrap
```
## 15. 错误处理
```
try
  " 可能出错的代码
catch
  echom "An error occurred: " . v:exception
finally
  " 清理代码
endtry
```
## 16. 用户配置
```
if !exists("g:plugin_option")
  let g:plugin_option = "default_value"
endif
```
## 17. 插件文档
```
" 在你的插件目录的 doc 文件夹中创建一个 .txt 文件
" 使用特定的格式编写文档
*plugin-name.txt*  Plugin description

INTRODUCTION                                    *plugin-name*

This plugin does...

COMMANDS                                        *plugin-name-commands*

:PluginCommand                                  *:PluginCommand*
    Description of the command
```

---

# 调试 Vim 插件

## 1. 使用 `echom` 命令

在插件代码中添加调试输出：
```
echom "Debug: Variable value is " . g:some_variable
```
之后可以使用 `:messages` 命令查看这些输出。

## 2. 使用 Vim 的调试模式

在命令行中启动 Vim 时使用 `-D` 选项：
```
vim -D your_file.txt
```
这会在每次执行命令时暂停，让你逐步执行代码。

## 3. 使用 `:debug` 命令

在 Vim 中，使用 `:debug` 命令来调试特定的函数或命令：
```
:debug call YourFunction()
```
## 4. 使用 `verbose` 选项

设置 `verbose` 选项可以让 Vim 显示更多的信息：
```
:set verbose=1
" 或者更高的级别
:set verbose=9
```
## 5. 使用日志文件

将调试信息写入日志文件：
```
call writefile(['Debug: ' . string(g:some_variable)], '/path/to/logfile.txt', 'a')
```
## 6. 使用 Vim 的 profiling 功能

这对于性能调试很有用：
```
:profile start profile.log
:profile func *
:profile file *
" 执行你想要分析的操作
:profile pause
:noautocmd qall!
```
## 7. 使用 `try`-`catch` 块

在可能出错的代码周围使用 `try`-`catch` 块来捕获和处理错误：
```
try
  " 你的代码
catch
  echom "Error occurred: " . v:exception
endtry
```
## 8. 检查 Vim 的 runtimepath

确保你的插件在正确的路径中：
```
:set runtimepath?
```
## 9. 使用 Vim 的内置调试器

Vim 8.1 及以上版本包含一个内置的调试器，可以通过 `:breakadd` 和 `:breakdel` 命令设置断点。

## 10. 使用外部工具

有些开发者喜欢使用像 `Vimspector` 这样的高级调试插件。

## 调试步骤示例

1. 在你的插件代码中添加调试输出：
```
function! DisplayVimVersion()
  echom "Debug: Entering DisplayVimVersion function"
  echo "Vim version: " . v:version
  echom "Debug: Exiting DisplayVimVersion function"
endfunction
```
2. 保存插件文件并重新加载：
```
:source %
```
3. 执行你的函数：
```
:call DisplayVimVersion()
```
4. 查看调试输出：
```
:messages
```
