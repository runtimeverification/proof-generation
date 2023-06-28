namespace zk {
template <typename T> struct set {
private:
  LinkedList<T> list;

public:
  bool contains(const T &value, typename LinkedList<T>::Node *head) const {
    typename LinkedList<T>::Iterator element(head);
    for (; element != list.end(); ++element) {
      if (*element == value) {
        return true;
      }
    }
    return false;
  }

  bool insert(const T &value, typename LinkedList<T>::Node *&head) {
    if (contains(value, head)) {
      return false;
    }

    list.insert_back(head, value);
    return true;
  }

  void remove(const T &value, typename LinkedList<T>::Node *&head) {
    typename LinkedList<T>::Iterator it = list.begin(head);
    while (it != list.end()) {
      if (*it == value) {
        if (it.current->prev != nullptr) {
          it.current->prev->next = it.current->next;
        } else {
          head = it.current->next;
        }

        if (it.current->next != nullptr) {
          it.current->next->prev = it.current->prev;
        }
        std::free(it.current);
        break;
      }
      ++it;
    }
  }

  size_t size(typename LinkedList<T>::Node *head) const {
    size_t count = 0;
    typename LinkedList<T>::Iterator element(head);
    while (element != list.end()) {
      ++element;
      ++count;
    }
    return count;
  }

  /*T &back(typename LinkedList<T>::Node *head) {
    assert(!empty(head));
    typename LinkedList<T>::Node *current = head;
    while (current->next != nullptr) {
      current = current->next;
    }
    return current->data;
  }*/

  // typename LinkedList<T>::Iterator find(const T &first,
  //                                       typename LinkedList<T>::Node *head) {
  //   typename LinkedList<T>::Iterator it(head);
  //   for (; it != list.end(); ++it) {
  //     if (it->first == first) {
  //       return it;
  //     }
  //   }
  //   return list.end();
  // }

    struct Iterator {
    typename LinkedList<T>::Iterator listIterator;
    explicit Iterator(typename LinkedList<T>::Node *node)
        : listIterator(node) {}

    T &operator*() const { return *listIterator; }
    T *operator->() const { return &(*listIterator); }

    Iterator &operator++() {
      ++listIterator;
      return *this;
    }

    Iterator operator++(int) {
      Iterator temp = *this;
      ++(*this);
      return temp;
    }

    bool operator==(const Iterator &other) const {
      return listIterator == other.listIterator;
    }

    bool operator!=(const Iterator &other) const { return !(*this == other); }
  };

  typename set<T>::Iterator begin(typename LinkedList<T>::Node *head) {
    return Iterator(head); // list.begin(head);
  }

  typename set<T>::Iterator end() { return Iterator(nullptr); }

  typename set<T>::Iterator find(const T &first,
                                    typename LinkedList<T>::Node *head) {
    typename set<T>::Iterator it(head);
    typename set<T>::Iterator end = this->end();
    for (; it != end; ++it) {
      if (*it == first) {
        return it;
      }
    }
    return end;
  }

  // typename LinkedList<T>::Iterator end() { return list.end(); }
  // typename LinkedList<T>::Iterator begin(typename LinkedList<T>::Node *head) {
  //   return list.begin(head);
  // }
};
} // namespace zk