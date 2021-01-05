export const levels = {
  LOG: 0,
  WARN: 1,
  ERROR: 2,
};

export const formats = {
  OTHER: 0,
  // JSON types (+ undefined)
  STRING: 1,
  NUMBER: 2,
  BOOLEAN: 3,
  NULL: 4,
  UNDEFINED: 5,
  ARRAY: 6,
  OBJECT: 7,
  // ML types
  LIST: 8,
};

const listToArray = (value) => {
  const out = [];
  let current = value;

  while (current !== 0) {
    if (Array.isArray(current) && current.length === 2) {
      out.push(current[0]);
      current = current[1];
    } else {
      return undefined;
    }
  }

  return out;
};

const description = (value) => {
  if (typeof value === "string") {
    return { format: formats.STRING, description: value };
  } else if (typeof value === "number" || typeof value === "bigint") {
    return { format: formats.NUMBER, description: String(value) };
  } else if (typeof value === "boolean") {
    return { format: formats.BOOLEAN, description: String(value) };
  } else if (typeof value === "function") {
    return { format: formats.OTHER, description: "(function)" };
  } else if (typeof value === "symbol") {
    return { format: formats.OTHER, description: "(symbol)" };
  } else if (value === null) {
    return { format: formats.NULL, description: "null" };
  } else if (value === undefined) {
    return { format: formats.UNDEFINED, description: "undefined" };
  } else if (Array.isArray(value)) {
    return { format: formats.ARRAY, description: JSON.stringify(value) };
  } else if (value !== null && typeof value === "object") {
    return { format: formats.OBJECT, description: JSON.stringify(value) };
  } else {
    return { format: formats.OTHER, description: "Unknown value" };
  }
};

const alternate = (value) => {
  const listFormat = listToArray(value);

  if (listFormat !== undefined && listFormat.length >= 3) {
    return [{ format: formats.LIST, description: JSON.stringify(listFormat) }];
  } else {
    return null;
  }
};

const formatArgs = (...args) =>
  args.map((value) => ({
    label: description(value),
    alternate: alternate(value),
  }));

export const create = () => {
  const messages = [];

  const console = {
    log: (...args) => {
      messages.push({ level: levels.LOG, parts: formatArgs(...args) });
    },
    warn: (...args) => {
      messages.push({ level: levels.WARN, parts: formatArgs(...args) });
    },
    error: (...args) => {
      messages.push({ level: levels.ERROR, parts: formatArgs(...args) });
    },
  };

  return { messages, console };
};
