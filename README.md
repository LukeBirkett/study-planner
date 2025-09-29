# Planner

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

