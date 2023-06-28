#include <cassert>

namespace zk {
template <typename T> struct vector {
private:
  LinkedList<T> list;
  size_t size_;

public:
  vector() : size_(0) {}

  size_t size() const { return size_; }

  bool empty() const { return size_ == 0; }

  void push_front(const T &value, typename LinkedList<T>::Node *&head) {
    list.insert_front(head, value);
    ++size_;
  }

  void push_back(const T &value, typename LinkedList<T>::Node *&head) {
    list.insert_back(head, value);
    ++size_;
  }

  T &at(size_t index, typename LinkedList<T>::Node *head) {
    assert(index < size_);

    typename LinkedList<T>::Iterator it(head);
    for (size_t i = 0; i < index; ++i) {
      ++it;
    }
    return *it;
  }

  const T &at(size_t index, typename LinkedList<T>::Node *head) const {
    assert(index < size_);

    typename LinkedList<T>::Iterator it(head);
    for (size_t i = 0; i < index; ++i) {
      ++it;
    }
    return *it;
  }

  T &back(typename LinkedList<T>::Node *head) {
    assert(!empty());
    typename LinkedList<T>::Node *current = head;
    while (current->next != nullptr) {
      current = current->next;
    }
    return current->data;
  }

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

  typename vector<T>::Iterator begin(typename LinkedList<T>::Node *head) {
    return Iterator(head); // list.begin(head);
  }

  typename vector<T>::Iterator end() { return Iterator(nullptr); }

  typename vector<T>::Iterator find(const T &first,
                                    typename LinkedList<T>::Node *head) {
    typename vector<T>::Iterator it(head);
    typename vector<T>::Iterator end = this->end();
    for (; it != end; ++it) {
      if (*it == first) {
        return it;
      }
    }
    return end;
  }

  T pop_back(typename LinkedList<T>::Node *&head) {
    assert(!empty());
    --size_;
    return list.remove_back(head);
  }

  struct ReverseIterator {
    typename LinkedList<T>::ReverseIterator listIterator;
    explicit ReverseIterator(typename LinkedList<T>::Node *node)
        : listIterator(node) {}

    T &operator*() const { return *listIterator; }
    T *operator->() const { return &(*listIterator); }

    ReverseIterator &operator++() {
      --listIterator;
      return *this;
    }

    ReverseIterator operator++(int) {
      ReverseIterator temp = *this;
      ++(*this);
      return temp;
    }

    bool operator==(const ReverseIterator &other) const {
      return listIterator == other.listIterator;
    }

    bool operator!=(const ReverseIterator &other) const {
      return !(*this == other);
    }
  };

  typename vector<T>::ReverseIterator
  rbegin(typename LinkedList<T>::Node *tail) {
    return ReverseIterator(tail); // list.begin(head);
  }

  typename vector<T>::ReverseIterator rend() {
    return ReverseIterator(nullptr);
  }
};
} // namespace zk