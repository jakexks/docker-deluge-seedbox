### deluge-torrent-seedbox ###

A deluge seedbox that just works!

Run with
```docker run -d --name deluge -p 80:80 -p 8112:8112 -p 58846:58846 -p 58847:58847 -p 58847:58847/udp -v /path/to/deluge/data:/home/deluge jakexks/deluge-torrent-seedbox```

Then visit http://<your host>:8112 for the deluge web UI, or connect the desktop client to 58846 (the default).
Your downloads directory is also served over http on port 80.

The default username/password is deluge:deluge. I recommend changing this by editing the .config/deluge/auth file in your deluge data directory.

You should also change the .htpasswd file in your docker data directory to secure your downloads folder.
