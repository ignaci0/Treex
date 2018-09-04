defmodule Treex do
  @moduledoc """
  Convenient module for using the `gb_trees` from erlang's
  standard library.

  It reorders the arguments so the tree is always passed
  first and therefore, it can be used with the pipe operators.

  And therefore by using Treex instead, code can be written as:

  ```elixir
  t = Treex.empty()
        |> Treex.enter("hello", :world)
        |> Treex.enter(:hello, "world")
  ```

  As an additional facility this module implements a `stream/1`
  to traverse all `{key, value}` from the given tree.

  Its functions also hints when errors can be raised. Most of them
  will be `FunctionClauseError`

  Function's documentation is provided for the IDE's to get it. For
  full details, refer to the official one at
  [reference documents](http://erlang.org/doc/man/gb_trees.html)
  """

  @type gb_tree_node() :: nil | {any(), any(), any(), any()}

  @opaque t() :: {non_neg_integer(), gb_tree_node()}

  @doc """
  Rebalances `tree`. Notice that this is rarely necessary,
  but can be motivated when many nodes have been deleted
  from the tree without further insertions. Rebalancing
  can then be forced to minimize lookup times, as deletion
  does not rebalance the tree.
  """
  @spec balance(t()) :: t()
  def balance(tree) do
    :gb_trees.balance(tree)
  end

  @doc """
  Removes the node with key `key` from `tree` and returns the
  new tree. Assumes that the key is present in the tree,
  crashes otherwise.
  """
  @spec delete!(t(), any()) :: t()
  def delete!(tree, key) do
    :gb_trees.delete(key, tree)
  end

  @doc """
  Removes the node with key `key` from `tree` if the key is
  present in the tree, otherwise does nothing.

  Returns the new tree.
  """
  @spec delete_any(t(), any()) :: t()
  def delete_any(tree, key) do
    :gb_trees.delete_any(key, tree)
  end

  @doc """
  Returns a `{value, tree}` tuple from node with key
  `key` and new tree without the node with this value.

  Assumes that the node with `key` is present in the
  tree, crashes otherwise.
  """
  @spec take!(t(), any()) :: {any(), t()}
  def take!(tree, key) do
    :gb_trees.take(key, tree)
  end

  @doc """
  Returns a `{value, tree2}` from node with key `key`;
  new tree without the node with this value.

  Returns error if the node with the key is not present in the tree.
  """
  @spec take_any(t(), any()) :: :error | {any(), t()}
  def take_any(tree, key) do
    :gb_trees.take_any(key, tree)
  end

  @doc """
  Returns a new empty tree.
  """
  @spec empty() :: t()
  def empty() do
    :gb_trees.empty()
  end

  @doc """
  Inserts `key` with value Value into `tree` if the key
  is not present in the tree, otherwise updates Key
  to value `value` in `tree`.

  Returns the new tree.
  """
  @spec enter(t(), any(), any()) :: t()
  def enter(tree, key, value) do
    :gb_trees.enter(key, value, tree)
  end

  @doc """
  Retrieves the value stored with `key` in `tree`.

  Assumes that the key is present in the tree, crashes otherwise.
  """
  @spec get!(t(), any()) :: t()
  def get!(tree, key) do
    :gb_trees.get(key, tree)
  end

  @doc """
  Inserts `key` with value `value` into `tree`
  and returns the new tree.

  Assumes that the key is not present in the tree,
  crashes otherwise.
  """
  @spec insert!(t(), any(), any()) :: t()
  def insert!(tree, key, value) do
    :gb_trees.insert(key, value, tree)
  end

  @doc """
  Returns `true` if `key` is present in `tree`, otherwise `false`.
  """
  @spec defined?(t(), any()) :: boolean()
  def defined?(tree, key) do
    :gb_trees.is_defined(key, tree)
  end

  @doc """
  Returns `true` if `tree` is an empty tree, othwewise `false`.
  """
  @spec empty?(t()) :: boolean()
  def empty?(tree) do
    :gb_trees.is_empty(tree)
  end

  @doc """
  Returns an iterator that can be used for traversing the
  entries of `tree`; see `next/1`. The implementation of
  this is very efficient; traversing the whole tree using
  `next/1` is only slightly slower than getting the list
  of all elements using `to_list/1` and traversing that.

  The main advantage of the iterator approach is that it
  does not require the complete list of all elements to
  be built in memory at one time.
  """
  @spec iterator(t()) :: [gb_tree_node()]
  def iterator(tree) do
    :gb_trees.iterator(tree)
  end

  @doc """
  Returns an iterator that can be used for traversing
  the entries of `tree`; see `next/1`.

  The difference as compared to the iterator
  returned by `iterator/1` is that the first key greater
  than or equal to `key` is returned.
  """
  @spec iterator(t(), any()) :: [gb_tree_node()]
  def iterator(tree, key) do
    :gb_trees.iterator_from(key, tree)
  end

  @doc """
  Returns the keys in `tree` as an ordered list.
  """
  @spec keys(t()) :: [any()]
  def keys(tree) do
    :gb_trees.keys(tree)
  end

  @doc """
  Returns `{key, value}`, where `key` is the largest key in `tree`,
  and `value` is the value associated with this key.

  Assumes that the tree is not empty.
  """
  @spec largest!(t()) :: {any(), any()}
  def largest!(tree) do
    :gb_trees.largest(tree)
  end

  @doc """
  Looks up `key` in `tree`. Returns `{:value, value}`,
  or :none if `key` is not present.
  """
  @spec lookup(t(), any()) :: :none | {:value, any()}
  def lookup(tree, key) do
    :gb_trees.lookup(key, tree)
  end

  @doc """
  Maps function `fn(k, v) -> v2` to all key-value
  pairs of tree `tree`.

  Returns a new tree with the same set of keys as
  `tree` and the new set of values `v2`.
  """
  @spec map(t(), (any() -> any())) :: t()
  def map(tree, fun) do
    :gb_trees.map(fun, tree)
  end

  @doc """
  Returns `{key, value, iter2}`, where `key` is the
  smallest key referred to by iterator `it`, and
  `iter2` is the new iterator to be used for traversing
  the remaining nodes, or the atom `:none` if no nodes remain.
  """
  @spec next(:gb_trees.iter(any(), any())) :: :none | {any(), any(), :gb_trees.iter(any(), any())}
  def next(it) do
    :gb_trees.next(it)
  end

  @doc """
  Returns the number of nodes in `tree`.
  """
  @spec size(t()) :: non_neg_integer()
  def size(tree) do
    :gb_trees.size(tree)
  end

  @doc """
  Returns `{key, value}`, where `key` is the
  smallest key in `tree`, and `value` is the value
  associated with this key.

  Assumes that the tree is not empty.
  """
  @spec smallest!(t()) :: {any(), any()}
  def smallest!(tree) do
    :gb_trees.smallest(tree)
  end

  @doc """
  Returns `{key, value, tree2}`, where `key` is the largest
  key in `tree`, `value` is the value associated with this key,
  and `tree2` is this tree with the corresponding node deleted.

  Assumes that the tree is not empty.
  """
  @spec take_largest!(t()) :: {any(), any()}
  def take_largest!(tree) do
    :gb_trees.take_largest(tree)
  end

  @doc """
  Returns `{key, value, tree2}`, where `key` is the smallest key
  in `tree`, `value` is the value associated with this key,
  and `tree2` is this tree with the corresponding node
  deleted.

  Assumes that the tree is not empty.
  """
  @spec take_smallest!(t()) :: {any(), any()}
  def take_smallest!(tree) do
    :gb_trees.take_smallest(tree)
  end

  @doc """
  Converts a tree into an ordered list of key-value tuples.
  """
  @spec to_list(t()) :: [{any(), any()}]
  def to_list(tree) do
    :gb_trees.to_list(tree)
  end

  @doc """
  Updates `key` to value `value` in `tree` and returns the new tree.

  Assumes that the key is present in the tree.
  """
  @spec update!(t(), any(), any()) :: t()
  def update!(tree, key, value) do
    :gb_trees.update(key, value, tree)
  end

  @doc """
  Returns the values in `tree` as an ordered list, sorted
  by their corresponding keys.

  Duplicates are not removed.
  """
  @spec values(t()) :: [any()]
  def values(tree) do
    :gb_trees.values(tree)
  end

  @doc """
  Implements a stream for `tree`.

  Each value returned by the stream shall be a `{key, value}`
  tuple. The exact same behaviour can be implemented
  by using the iterator/1.

  Example:

  ```elixir
  Treex.empty()
    |> Treex.enter(:key1, 1)
    |> Treex.enter(:key2, 2)
    |> Treex.enter(:key3, 3)
    |> Treex.stream()
    |> Enum.reduce(0, fn({_k, v}, acc) -> acc+v end)
  ```
  returns `6`
  """
  def stream(tree) do
    Stream.resource(
      fn -> iterator(tree) end,
      fn(it) ->
        case next(it) do
          :none ->
            {:halt, it}
          {key, val, iter2} ->
            {[{key, val}], iter2}
        end
      end,
      fn(_it) -> :ok end)
  end

end
