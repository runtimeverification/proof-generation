def relu(s):
  if 0 < s:
    return s

  return 0

def layer_perceptron(X, W, b, f):
    assert(len(X) == len(W))

    i = 0
    s = 0

    while i < len(X):
        s = s + (W[i] * X[i])
        i = i + 1

    return f(s - b)
