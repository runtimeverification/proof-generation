#include <cassert>

namespace zk {
template <typename T> struct deque {
private:
  LinkedList<T> list;

public:
  bool empty(typename LinkedList<T>::Node *head) const {
    return head == nullptr;
  }

  size_t size(typename LinkedList<T>::Node *&head) {
    size_t count = 0;
    typename LinkedList<T>::Iterator it(head);
    while (it != list.end()) {
      ++count;
      ++it;
    }
    return count;
  }

  void push_front(const T &value, typename LinkedList<T>::Node *&head) {
    list.insert_front(head, value);
  }

  void push_back(const T &value, typename LinkedList<T>::Node *&head) {
    list.insert_back(head, value);
  }

  T &front(typename LinkedList<T>::Node *head) {
    assert(!empty(head));
    return *list.begin(head);
  }

  const T &front(typename LinkedList<T>::Node *head) const {
    assert(!empty(head));
    return *list.begin(head);
  }

  T &back(typename LinkedList<T>::Node *head) {
    assert(!empty(head));
    typename LinkedList<T>::Node *current = head;
    while (current->next != nullptr) {
      current = current->next;
    }
    return current->data;
  }

  const T &back(typename LinkedList<T>::Node *head) const {
    assert(!empty(head));
    typename LinkedList<T>::Node *current = head;
    while (current->next != nullptr) {
      current = current->next;
    }
    return current->data;
  }

  T& at(size_t index, typename LinkedList<T>::Node *head) {
    assert(index < size(head));
    typename LinkedList<T>::Iterator it(head);
    for (size_t i = 0; i < index; ++i) {
      ++it;
    }
    return *it;
  }

};
} // namespace zk