


建议所有机器做Raid5，而非直连盘
减少单块硬盘故障的维护成本
减少集群的维护成本，因为gluster会为每个挂载点启动一个服务进程
减少成本，如果是Raid1，加上至少2副本，则使用率仅为25%


Bricks
• Brick是一个节点和一个导出目录的集合，e.g. node1:/brick1
• Brick是底层的RAID或磁盘经XFS或ext4文件系统格式化而来，所以继承了文件系统的限制
• 每个节点上的brick数是不限的
• 理想的状况是，一个集群的所有Brick大小都一样



https://www.cnblogs.com/LuoboLiam/p/13788049.html