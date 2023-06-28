#include <cstdlib>
#include <cassert>

namespace zk {
template <typename T> struct LinkedList {
  struct Node {
    T data;
    Node *prev;
    Node *next;
  };

  void insert_front(Node *&head, const T &value) {
    Node *newNode = static_cast<Node *>(std::malloc(sizeof(Node)));
    newNode->data = value;
    newNode->prev = nullptr;
    newNode->next = head;

    if (head != nullptr) {
      head->prev = newNode;
    }

    head = newNode;
  }

  void insert_back(Node *&head, const T &value) {
    Node *newNode = static_cast<Node *>(std::malloc(sizeof(Node)));
    newNode->data = value;
    newNode->prev = nullptr;
    newNode->next = nullptr;

    if (head == nullptr) {
      head = newNode;
    } else {
      Node *current = head;
      while (current->next != nullptr) {
        current = current->next;
      }
      current->next = newNode;
      newNode->prev = current;
    }
  }

  T remove_front(Node *&head) {
    assert(head != nullptr); // List is empty
    Node *current = head;
    head = head->next;
    if (head != nullptr) {
      head->prev = nullptr;
    }
    return current->data;
  }

  T remove_back(LinkedList<T>::Node *&head) {
    assert(head != nullptr); // List is empty

    LinkedList<T>::Node *prev = nullptr;
    LinkedList<T>::Node *current = head;

    if (head->next == nullptr) {
      head = nullptr;
      return current->data; // List has only one node
    }

    while (current->next != nullptr) {
      prev = current;
      current = current->next;
    }

    prev->next = nullptr;
    return current->data;
  }

  struct Iterator {
    Node *current;

    explicit Iterator(Node *node) : current(node) {}

    T &operator*() const { return current->data; }

    T *operator->() const { return &(current->data); }

    Iterator &operator++() {
      current = current->next;
      return *this;
    }

    Iterator &operator--() {
      current = current->prev;
      return *this;
    }

    bool operator!=(const Iterator &other) const {
      return current != other.current;
    }

    bool operator==(const Iterator &other) const {
      return current == other.current;
    }
  };

  Iterator begin(Node *head) { return Iterator(head); }

  Iterator end() const { return Iterator(nullptr); }
};
} // namespace zk