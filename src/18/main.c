#include "main.h"

struct node* create_node(int num) {
  struct node* node = (struct node*) malloc(sizeof(struct node));
  node->number = num;
  node->left = NULL;
  node->right = NULL;
  return node;
}

struct node* generate_default() {
  struct node* node = create_node(3);

  node->left = create_node(7);
  node->right = create_node(4);

  node->left->left = create_node(2);
  node->left->right = create_node(4);
  node->right->left = node->left->right;
  node->right->right = create_node(6);

  node->left->left->left = create_node(8);
  node->left->left->right = create_node(5);
  node->left->right->left = node->left->left->right;
  node->left->right->right = create_node(9);
  node->right->left->left = node->left->right->left;
  node->right->left->right = node->left->right->right;
  node->right->right->left = node->right->left->right;
  node->right->right->right = create_node(3);
  return node;
}

static void free_left_row(struct node* node) {
  if (node) {
    free_left_row(node->left);
    node->left = NULL;
    free(node);
  }
}

void free_node(struct node* node) {
  if (node == NULL)
    return;
  struct node* next_node;
  for (; node; node = next_node) {
    next_node = node->right;
    free_left_row(node);
  }
}

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

int main() {
  struct node* init_node = generate_default();
  printf("%d\n", max_path(init_node)); // should be 23
  free_node(init_node);
  init_node = NULL;
  return 0;
}
