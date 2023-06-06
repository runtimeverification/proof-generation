def svm(X, W, b):
    assert(len(X) == len(W))

    i = 0
    s = 0

    while i < len(X):
        s = s + (W[i] * X[i])
        i = i + 1

    if s > b:
      return 1

    return -1
