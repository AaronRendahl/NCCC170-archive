rm /Users/rend0020/SandboxWork/NCCC170-archive/nccc170.uark.edu/.DS_Store
rm /Users/rend0020/SandboxWork/NCCC170-archive/nccc170.uark.edu/*/.DS_Store
rsync -avh --delete --rsh=ssh /Users/rend0020/SandboxWork/NCCC170-archive/nccc170.uark.edu/ stat:public_html/nccc170_history/
