def svm(X, W, b):
    assert(len(X) == len(W))

    s = 0

    for i in range(0, len(X)):
        s += w[i] * x[i]

    if s - b > 0:
      return 1

    return -1
