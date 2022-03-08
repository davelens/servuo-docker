# servuo-docker
This repo was made to allow the most recent ServUO iteration (publish 57.1) to run inside a Docker container on a Synology NAS. While that's a very specific usecase, I'm fairly sure *any* platform running this container will be able to get it working.

I mostly made this for my own use case, but just in case you want to fiddle with this, a little explanation below.

## Install
1. Build your container
2. Create/configure your volumes. There's one volume for servuo itself, and one for the UO game files ServUO needs.  
   **Caveat**. With a Synology NAS host you can do the previous steps easily with the provided interface from the official Docker pkg. On another host you'll need to map these volumes yourself in `docker-compose.yml`.
3. Download the ServUO files and put them in the appropriate volume folder. If you want to connect using the Classic Client, read the note on that below.
4. Start your container
5. Run `dotnet build` in your container to build ServUO.
6. Run `mono /servuo/ServUO.exe` in your container and follow further instructions.

## Connecting with the Classic Client (ClassicUO, ClassicAssist, Razor, RazorEnhanced,...)
Connecting with the Enhanced Client worked immediately, but the ServUO suffers from a known issue in regards to the Classic Client for servers running inside a Docker container. The problem lies within its server list mapping, and a solution exists in the form of a PR (See [ServUO #4955](https://github.com/ServUO/ServUO/pull/4955)).

Basicly you want to build ServUO with the source files from the PR linked above, and adjust `Config/ServerListMap.xml` with the following contents:

```xml
<serverListMap>
    <!-- entry elements define a remote cidr address match that maps to a destination
    cidrmatch   String  IP CIDR to match against the remote address, such as 192.168.1.0/24
    destination String  Destination IP to use if matched
    -->

    <!-- Example 1 - Single address match where NATing is insufficient / misconfigued (SSH tunnel + docker)
    <entry cidrmatch="172.18.0.1/32" destination="127.0.0.1"/>
    -->

    <!-- Example 2 - Local network match where NAT'ing is insufficent / misconfigured (docker)
    <entry cidrmatch="192.168.1.0/24" destination="192.168.1.100"/>
    -->

    <entry cidrmatch="172.17.0.2/24" destination="192.168.0.184"/>
</serverListMap>
```
If you don't understand this: ServUO requires you to map your **internal** Docker IP (=cidrmatch) to your **host's network IP** (=destination). The interal Docker IP is usually something in the range of `172.17.x.x`, and you can find it using `docker inspect`.
