<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
--- 


#### Set New Venv

```
python -m venv [myenv]
source [myenv]/bin/activate
pip install ipykernel
python -m ipykernel install --user --name=[myenv]
pip install notebook
jupyter notebook
```

The Kernel is a Persistent Pointer. This means if you call all envs the same name (myenv) the kernel will always point to the most recently created kernel. This is why is it impact to give envs a unique name

```
pip install numpy
pip install matplotlib
pip install scikit-learn
```
```
jupyter kernelspec list
jupyter kernelspec uninstall myenv
```

```
touch my_script.py
```





[Common Pitfalls in Computer Vision & AI Projects](https://open.spotify.com/episode/3gATEskqys0M3ubtVvRulf?si=lyeP03qDT-KMXpMjiSczBA&nd=1&utm_medium=organic&product=open&%24full_url=https%3A%2F%2Fopen.spotify.com%2Fepisode%2F3gATEskqys0M3ubtVvRulf%3Fsi%3DlyeP03qDT-KMXpMjiSczBA&feature=organic&_branch_match_id=1439916255368734107&_branch_referrer=H4sIAAAAAAAAA72NywrCMBREvybd2WojLoQi9bWRgqiIO0nTmzY2JvEmUerCb7cK%2FoIwi2EOh2m8t26aJM4aL0UXM2tjJXWbzCyaKnCfGQs6IulYBKXOAVXWfBRCc5Ku%2B3xw%2FLO5ufYTWOlMBX2jdX5YufbWuWFBQ%2BmP911QgtC1k4QuVQfbIb0tD4NNcbLFRe75c55%2Fv5hSJePtP%2F5IOtFVT0eRAOYDQmawZlry6IUgAFHq%2BlyieTjAbNGgucIb4bFdyzUBAAA%3D)