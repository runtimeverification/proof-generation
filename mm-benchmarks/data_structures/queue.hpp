namespace zk {
template <typename T> struct queue {
private:
  LinkedList<T> list;

public:
  bool empty(typename LinkedList<T>::Node *head) const {
    return head == nullptr;
  }
  void push(const T &value, typename LinkedList<T>::Node *&head) {
    list.insert_back(head, value);
  }

  T pop(typename LinkedList<T>::Node *&head) {
    assert(!empty(head));
    return list.remove_front(head);
  }

  T &front(typename LinkedList<T>::Node *head) {
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

};
} // namespace zk