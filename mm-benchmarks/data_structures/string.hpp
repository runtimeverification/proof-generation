#include <cstdint>

#define A 54059
#define B 76963
#define FIRSTH 37

struct String {
    const char *str;

    explicit String() : str(nullptr) {}

    String(const char *c) : str(c) {}

    bool operator==(String str2) {
        return this->hash() == str2.hash();
    }

    std::size_t hash() {
        std::size_t h = FIRSTH;
        const char *c = this->str;
        //while (c[0] != '\0') {
          h = (h * A) ^ (((std::size_t)c[0]) * B);
          c++;
       // }
        return h;
    }
};