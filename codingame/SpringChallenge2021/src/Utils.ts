/* eslint-disable no-extend-native */
// Set.prototype.filter = function filter(f) {
//   const newSet = new Set();
//   for (const v of this) if (f(v)) newSet.add(v);
//   return newSet;
// };

export class ExtendSet<T> extends Set {
  filter(predicate: (value: T) => boolean ): ExtendSet<T> {
    const newSet: ExtendSet<T> = new ExtendSet<T>();
    for (const value of this) if (predicate(value)) newSet.add(value);
    return newSet;
  }

  toString(): string {
    const stringValues: string[] = [];
    this.forEach((v) => stringValues.push(v.toString()));
    return `Set (${stringValues})`;
  }
}
