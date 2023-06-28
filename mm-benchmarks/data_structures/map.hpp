namespace zk {
template <typename K, typename V> struct map {
  struct Entry {
    K first;
    V second;
  };
  LinkedList<Entry> list;

  void insert(const K &first, const V &second,
              typename LinkedList<Entry>::Node *&head) {
    typename LinkedList<Entry>::Iterator entry(head);
    for (; entry != list.end(); ++entry) {
      if (entry->first == first) {
        entry->second = second;
        return;
      }
    }

    Entry newEntry;
    newEntry.first = first;
    newEntry.second = second;
    list.insert_back(head, newEntry);
  }

  bool contains(const K &first, typename LinkedList<Entry>::Node *&head) {
    typename LinkedList<Entry>::Iterator entry(head);
    for (; entry != list.end(); ++entry) {
      if (entry->first == first) {
        return true;
      }
    }
    return false;
  }

  V &at(const K &first, typename LinkedList<Entry>::Node *&head) {

    typename LinkedList<Entry>::Iterator current(head);
    for (; current != list.end(); ++current) {
      if (current->first == first) {
        return current->second;
      }
    }
    // first not found in the map.
    exit(1);
  }

  struct Iterator {
    typename LinkedList<Entry>::Node *current;
    explicit Iterator(typename LinkedList<Entry>::Node *head) : current(head) {}
    Entry &operator*() { return current->data; }
    Entry *operator->() { return &current->data; }
    Iterator &operator++() {
      current = current->next;
      return *this;
    }
    Iterator &operator--() {
      current = current->prev;
      return *this;
    }
    bool operator==(const Iterator &other) const {
      return current == other.current;
    }
    bool operator!=(const Iterator &other) const {
      return current != other.current;
    }
  };

  map<K, V>::Iterator find(const K &first,

                           typename LinkedList<map<K, V>::Entry>::Node *head) {
    typename map<K, V>::Iterator it(head);
    typename map<K, V>::Iterator end = this->end();
    for (; it != end; ++it) {
      if (it->first == first) {
        return it;
      }
    }
    return end;
  }

  map<K, V>::Iterator end() { return Iterator(nullptr); }
  map<K, V>::Iterator begin(typename LinkedList<map<K, V>::Entry>::Node *head) {
    return Iterator(head); // list.begin(head);
  }
};
} // namespace zk