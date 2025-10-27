#include "main.h"

static inline int max(int a, int b) {
  return a > b ? a : b;
}

static int max_path_rec(struct node* node) {
  if (node->right == NULL || node->left == NULL)
    return node->number;
  return node->number + max(max_path_rec(node->right), max_path_rec(node->left));
}

int max_path(struct node* node) {
  if (node == NULL)
    return 0;
  return max_path_rec(node);
}

int main(int argc, char* argv[]) {
  return 0;
}
