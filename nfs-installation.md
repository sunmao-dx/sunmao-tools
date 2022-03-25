## NFS Install
**System: Ubuntu 18.04**
- 安装服务端和客户端
    ```bash
    $ apt install nfs-kernel-server nfs-common
    ```
    其中 `nfs-kernel-server` 为服务端，`nfs-common` 为客户端。

- 配置 nfs 共享目录
    在`$HOME`下创建共享目录，并在 /etc/exports 中导出:
    ```bash
    $ mkdir nfs-share
    $ sudo vim /etc/exports 
    /home/user/nfs-share *(rw,sync,no_root_squash,no_subtree_check)
    ```
    格式如下:  
    共享目录 可访问共享目录的ip(共享目录权限列表)  
    各字段解析如下：  
    `/home/user/nfs-share`: 要共享的目录  
    `：`指定可以访问共享目录的用户 ip, * 代表所有用户。192.168.3.　指定网段。192.168.3.29 指定 ip  
    `rw`：可读可写。如果想要只读的话，可以指定 ro  
    `sync`：文件同步写入到内存与硬盘中  
    `async`：文件会先暂存于内存中，而非直接写入硬盘  
    `no_root_squash`：登入 nfs 主机使用分享目录的使用者，如果是 root 的话，那么对于这个分享的目录来说，他就具有 root 的权限！这个项目『极不安全』，不建议使用！但如果你需要在客户端对 nfs 目录进行写入操作。你就得配置 no_root_squash。方便与安全不可兼得  
    `root_squash`：在登入 nfs 主机使用分享之目录的使用者如果是 root 时，那么这个使用者的权限将被压缩成为匿名使用者，通常他的 UID 与 GID 都会变成 nobody 那个系统账号的身份  
    `subtree_check`：强制 nfs 检查父目录的权限（默认）  
    `no_subtree_check`：不检查父目录权限  

- 配置完成后，执行以下命令导出共享目录，并重启 nfs 服务:

    ```bash
    $ sudo exportfs -a      
    $ sudo service nfs-kernel-server restart
    ```
    服务端配置完成!

- 客户端挂载共享文件系统
    ```bash
    # nfs-share 共享文件系统挂载到 /mnt
    $ sudo mount nfs-server-ip:/home/user/nfs-share /mnt
