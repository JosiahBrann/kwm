#ifndef NODE_H
#define NODE_H

#include "types.h"
#include "axlib/display.h"

/* NOTE(koekeishiya): The following functions are working as expected. */

/* NOTE(koekeishiya): The following functions are under testing. */
void CreateLeafNodePair(ax_display *Display, tree_node *Parent, int FirstWindowID, int SecondWindowID, split_type SplitMode);
tree_node *CreateLeafNode(ax_display *Display, tree_node *Parent, int WindowID, int ContainerType);

/* NOTE(koekeishiya): The following functions still need to be investigated. */
tree_node *CreateRootNode();
link_node *CreateLinkNode();
tree_node *CreateLeafNode(screen_info *Screen, tree_node *Parent, int WindowID, int ContainerType);
void CreateLeafNodePair(screen_info *Screen, tree_node *Parent, int FirstWindowID, int SecondWindowID, split_type SplitMode);
void CreatePseudoNode();
void RemovePseudoNode();
bool IsLeafNode(tree_node *Node);
bool IsPseudoNode(tree_node *Node);
bool IsLeftChild(tree_node *Node);
bool IsRightChild(tree_node *Node);
void ToggleNodeSplitMode(screen_info *Screen, tree_node *Node);
void ToggleTypeOfFocusedNode();
void ChangeTypeOfFocusedNode(node_type Type);
void SwapNodeWindowIDs(tree_node *A, tree_node *B);
void SwapNodeWindowIDs(link_node *A, link_node *B);
split_type GetOptimalSplitMode(tree_node *Node);
void ResizeWindowToContainerSize(tree_node *Node);
void ResizeWindowToContainerSize(link_node *Node);
void ResizeWindowToContainerSize(window_info *Window);
void ResizeWindowToContainerSize();
void ModifyContainerSplitRatio(double Offset);
void ModifyContainerSplitRatio(double Offset, int Degrees);
tree_node *FindLowestCommonAncestor(tree_node *A, tree_node *B);

#endif
