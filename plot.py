#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

titles = {
        "results/zplug-inst.txt" : "zplug",
        "results/zgen-inst.txt" : "zgen",
        "results/zplugin-light-inst.txt" : "zplugin light",
        "results/zplugin-load-inst.txt" : "zplugin load",
        "results/zplugin-turbo-inst.txt" : "zplugin (Turbo) load",

        "results/zplug.txt" : "zplug",
        "results/zgen.txt" : "zgen",
        "results/zplugin-light.txt" : "zplugin light",
        "results/zplugin-load.txt" : "zplugin load",
        "results/zplugin-turbo.txt" : "zplugin (Turbo) load",
}

files_inst = [
        "results/zplug-inst.txt",
        "results/zgen-inst.txt",
        "results/zplugin-light-inst.txt",
        "results/zplugin-load-inst.txt",
        "results/zplugin-turbo-inst.txt",
]

files_startup = [
        "results/zplug.txt",
        "results/zgen.txt",
        "results/zplugin-light.txt",
        "results/zplugin-load.txt",
        "results/zplugin-turbo.txt",
]

#
# Installation-times plot
#

data={}
for fname in files_inst:
    odd=0

    file = open( fname, "r" )
    lines = file.readlines()
    file.close()

    idata=[]
    for line in lines:
        if fname == "results/zplug-inst.txt":
            odd = 1 - odd
            if not odd:
                fields = line.split()
                idata.append( float(fields[ -2 ]) / 1000.0 )
        else:
            fields = line.split()
            idata.append( float(fields[ -2 ]) / 1000.0 )

    mean = np.mean(idata)
    data[titles[fname]]=mean

group_data = list(data.values())
group_names = list(data.keys())

fig, ax = plt.subplots(figsize=(8.2, 5))
ax.bar(group_names, group_data)

# Add a vertical line, here we set the style in the function call
ax.axhline(mean, ls='--', color='r')

# Now we'll move our title up since it's getting a little cramped
ax.title.set(y=1.05)

plt.title("Installation time, in seconds")

fig.savefig('plots/installation-times.png', transparent=False, dpi=80, bbox_inches="tight")

plt.show()

#
# Startup-times plot
#

data={}
for fname in files_startup:
    odd=0

    file = open( fname, "r" )
    lines = file.readlines()
    file.close()

    idata=[]
    for line in lines:
        if fname == "results/zplug.txt":
            odd = 1 - odd
            if not odd:
                fields = line.split()
                idata.append( float(fields[ -2 ]) )
        else:
            fields = line.split()
            idata.append( float(fields[ -2 ]) )

    mean = np.mean(idata)
    data[titles[fname]]=mean

group_data = list(data.values())
group_names = list(data.keys())

fig, ax = plt.subplots(figsize=(8.2, 5))
ax.bar(group_names, group_data)

# Add a vertical line, here we set the style in the function call
ax.axhline(mean, ls='--', color='r')

# Now we'll move our title up since it's getting a little cramped
ax.title.set(y=1.05)

plt.title("Startup time, in milliseconds")

fig.savefig('plots/startup-times.png', transparent=False, dpi=80, bbox_inches="tight")

plt.show()
