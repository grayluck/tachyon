---
layout: global
title: Configuration Settings
---

Tachyon configuration parameters fall into four categories: Master/Worker/Common(Master and
Worker)/User configurations. The environment configuration file responsible for setting system
properties is under conf/tachyon-env.sh. A template is provided with the zip:
conf/tachyon-env.sh.template.

# Common Configuration

The common configuration contains constants which specify paths and the log appender name.

<table class="table">
<tr><th>Property Name</th><th>Default</th><th>Meaning</th></tr>
<tr>
  <td>tachyon.home</td>
  <td>"/mnt/tachyon_default_home"</td>
  <td>Tachyon folder to store logs.r</td>
</tr>
<tr>
  <td>tachyon.underfs.address</td>
  <td>$tachyon.home + "/underfs"</td>
  <td>Tachyon folder in the underlayer file system</td>
</tr>
<tr>
  <td>tachyon.data.folder</td>
  <td>$tachyon.underfs.address + "/tachyon/data"</td>
  <td>Tachyon's data folder in the underlayer file system.</td>
</tr>
<tr>
  <td>tachyon.workers.folder</td>
  <td>$tachyon.underfs.address + "/tachyon/workers"</td>
  <td>Tachyon's workers folders in the underlayer file system.</td>
</tr>
<tr>
  <td>tachyon.usezookeeper</td>
  <td>false</td>
  <td>If setup master fault tolerant mode using ZooKeeper.</td>
</tr>
<tr>
  <td>tachyon.zookeeper.address</td>
  <td>null</td>
  <td>ZooKeeper address for master fault tolerance.</td>
</tr>
<tr>
  <td>tachyon.zookeeper.election.path</td>
  <td>"/election"</td>
  <td>Election folder in ZooKeeper.</td>
</tr>
<tr>
  <td>tachyon.zookeeper.leader.path</td>
  <td>"/leader"</td>
  <td>Leader folder in ZooKeeper.</td>
</tr>
</table>

# Master Configuration

The master configuration specifies information regarding the master node, such as address and port
number.

<table class="table">
<tr><th>Property Name</th><th>Default</th><th>Meaning</th></tr>
<tr>
  <td>tachyon.master.journal.folder</td>
  <td>"tachyon.home"/journal/</td>
  <td>The folder to store master journal log.</td>
</tr>
<tr>
  <td>tachyon.master.hostname</td>
  <td>localhost</td>
  <td>The externally visible hostname of Tachyon's master address.</td>
</tr>
<tr>
  <td>tachyon.master.port</td>
  <td>19998</td>
  <td>The port Tachyon's master node runs on.</td>
</tr>
<tr>
  <td>tachyon.master.web.port</td>
  <td>19999</td>
  <td>The port Tachyon's web interface runs on.</td>
</tr>
<tr>
  <td>tachyon.master.whitelist</td>
  <td>/</td>
  <td>The list of prefixes of the paths which are cacheable, separated by semi-colons. Tachyon will try to cache the cacheable file when it is read for the first time.</td>
</tr>
<tr>
  <td>tachyon.master.pinlist</td>
  <td></td>
  <td>The list of files that will remain in memory all the time. If the memory size is not sufficient, the exception will be raised for the last caching file's client.</td>
</tr>
</table>

# Worker Configuration

The worker configuration specifies information regarding the worker nodes, such as address and port
number.

<table class="table">
<tr><th>Property Name</th><th>Default</th><th>Meaning</th></tr>
<tr>
  <td>tachyon.worker.port</td>
  <td>29998</td>
  <td>The port Tachyon's worker node runs on.</td>
</tr>
<tr>
  <td>tachyon.worker.data.port</td>
  <td>29999</td>
  <td>The port Tachyon's worker's data server runs on.</td>
</tr>
<tr>
  <td>tachyon.worker.data.folder</td>
  <td>/mnt/ramdisk</td>
  <td>The path to the data folder for Tachyon's worker nodes. Note for macs the value should be "/Volumes/"</td>
</tr>
<tr>
  <td>tachyon.worker.memory.size</td>
  <td>128 MB</td>
  <td>Memory capacity of each worker node.</td>
</tr>
</table>

# User Configuration

The user configuration specifies values regarding file system access.

<table class="table">
<tr><th>Property Name</th><th>Default</th><th>Meaning</th></tr>
<tr>
  <td>tachyon.user.failed.space.request.limits</td>
  <td>3</td>
  <td>The number of times to request space from the file system before aborting</td>
</tr>
<tr>
  <td>tachyon.user.quota.unit.bytes</td>
  <td>8 MB</td>
  <td>The minimum number of bytes that will be requested from a client to a worker at a time</td>
</tr>
<tr>
  <td>tachyon.user.file.buffer.bytes</td>
  <td>1 MB</td>
  <td>The size of the file buffer to use for file system reads/writes.</td>
</tr>
</table>

# Example tachyon-env.sh File

    # Worker size set to 512 MB
    # Set worker folder to /Volumes/ramdist/tachyonworker

    export TACHYON_JAVA_OPTS="
      -Dtachyon.worker.memory.size=512MB
      -Dtachyon.worker.data.folder=/Volumes/ramdisk/tachyonworker/
    "