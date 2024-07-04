// To parse this data:
//
//   import { Convert, InfoEntity } from "./file";
//
//   const infoEntity = Convert.toInfoEntity(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export default  class  InfoEntity {
  code?: number;
  message?: string;
  data?: Data;
  request_id?: string;
}

export interface Data {
  topic_info?: TopicInfo;
  code?: number;
}

export interface TopicInfo {
  id?: number;
  cover_image_url?: string;
  vertical_image_url?: string;
  title?: string;
  description?: string;
  likes_count?: string;
  origin_likes_count?: number;
  comments_count?: string;
  origin_comments_count?: number;
  popularity_info?: string;
  fav_count?: string;
  comics_count?: number;
  comic_body_count?: number;
  tags?: string[];
  comics?: Comic[];
  first_comic_id?: number;
  user?: User;
  signing_status?: string;
  is_free?: boolean;
  update_status?: string;
  is_favourite?: boolean;
}

export interface Comic {
  id?: number;
  title?: string;
  cover_image_url?: string;
  is_pay_comic?: boolean;
  need_vip?: boolean;
  locked?: boolean;
  locked_code?: number;
  likes_count?: string;
  likes_count_number?: number;
  created_at?: CreatedAt;
  is_free?: boolean;
  is_vip_exclusive?: boolean;
  vip_exclusive_type?: number;
  vip_time_free_type?: number;
}

export enum CreatedAt {
  The0627 = "06-27",
}

export interface User {
  user_id?: number;
  nickname?: string;
  avatar?: string;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export class Convert {
  public static toInfoEntity(json: string): InfoEntity {
    return cast(JSON.parse(json), r("InfoEntity"));
  }

  public static infoEntityToJson(value: InfoEntity): string {
    return JSON.stringify(uncast(value, r("InfoEntity")), null, 2);
  }
}

function invalidValue(typ: any, val: any, key: any, parent: any = ''): never {
  const prettyTyp = prettyTypeName(typ);
  const parentText = parent ? ` on ${parent}` : '';
  const keyText = key ? ` for key "${key}"` : '';
  throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ: any): string {
  if (Array.isArray(typ)) {
    if (typ.length === 2 && typ[0] === undefined) {
      return `an optional ${prettyTypeName(typ[1])}`;
    } else {
      return `one of [${typ.map(a => {
        return prettyTypeName(a)  ;
      }).join(", ")}]`;
    }
  } else if (typeof typ === "object" && typ.literal !== undefined) {
    return typ.literal;
  } else {
    return typeof typ;
  }
}

function jsonToJSProps(typ: any): any {
  if (typ.jsonToJS === undefined) {
    const map: any = {};
    typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
    typ.jsonToJS = map;
  }
  return typ.jsonToJS;
}

function jsToJSONProps(typ: any): any {
  if (typ.jsToJSON === undefined) {
    const map: any = {};
    typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
    typ.jsToJSON = map;
  }
  return typ.jsToJSON;
}

function transform(val: any, typ: any, getProps: any, key: any = '', parent: any = ''): any {

  function transformPrimitive(typ: string, val: any): any {
    if (typeof typ === typeof val) {
      return val;
    }
    return invalidValue(typ, val, key, parent);
  }

  function transformUnion(typs: any[], val: any): any {
    // val must validate against one typ in typs
    const l = typs.length;
    for (let i = 0; i < l; i++) {
      const typ = typs[i];
      try {
        return transform(val, typ, getProps);
      } catch (_) {
      }
    }
    return invalidValue(typs, val, key, parent);
  }

  function transformEnum(cases: string[], val: any): any {
    if (cases.indexOf(val) !== -1) {
      return val;
    }
    return invalidValue(cases.map(a => {
      return l(a);
    }), val, key, parent);
  }

  function transformArray(typ: any, val: any): any {
    // val must be an array with no invalid elements
    if (!Array.isArray(val)) {
      return invalidValue(l("array"), val, key, parent);
    }
    return val.map(el => transform(el, typ, getProps));
  }

  function transformDate(val: any): any {
    if (val === null) {
      return null;
    }
    const d = new Date(val);
    if (isNaN(d.valueOf())) {
      return invalidValue(l("Date"), val, key, parent);
    }
    return d;
  }

  function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
    if (val === null || typeof val !== "object" || Array.isArray(val)) {
      return invalidValue(l(ref || "object"), val, key, parent);
    }
    const result: any = {};
    Object.getOwnPropertyNames(props).forEach(key => {
      const prop = props[key];
      const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
      result[prop.key] = transform(v, prop.typ, getProps, key, ref);
    });
    Object.getOwnPropertyNames(val).forEach(key => {
      if (!Object.prototype.hasOwnProperty.call(props, key)) {
        result[key] = transform(val[key], additional, getProps, key, ref);
      }
    });
    return result;
  }

  if (typ === "any") {
    return val;
  }
  if (typ === null) {
    if (val === null) {
      return val;
    }
    return invalidValue(typ, val, key, parent);
  }
  if (typ === false) {
    return invalidValue(typ, val, key, parent);
  }
  let ref: any = undefined;
  while (typeof typ === "object" && typ.ref !== undefined) {
    ref = typ.ref;
    typ = typeMap[typ.ref];
  }
  if (Array.isArray(typ)) {
    return transformEnum(typ, val);
  }
  if (typeof typ === "object") {
    return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
      : typ.hasOwnProperty("arrayItems") ? transformArray(typ.arrayItems, val)
        : typ.hasOwnProperty("props") ? transformObject(getProps(typ), typ.additional, val)
          : invalidValue(typ, val, key, parent);
  }
  // Numbers can be parsed by Date but shouldn't be.
  if (typ === Date && typeof val !== "number") {
    return transformDate(val);
  }
  return transformPrimitive(typ, val);
}

function cast<T>(val: any, typ: any): T {
  return transform(val, typ, jsonToJSProps);
}

function uncast<T>(val: T, typ: any): any {
  return transform(val, typ, jsToJSONProps);
}

function l(typ: any) {
  return { literal: typ };
}

function a(typ: any) {
  return { arrayItems: typ };
}

function u(...typs: any[]) {
  return { unionMembers: typs };
}

function o(props: any[], additional: any) {
  return { props, additional };
}

function m(additional: any) {
  return { props: [], additional };
}

function r(name: string) {
  return { ref: name };
}

const typeMap: any = {
  "InfoEntity": o([
    { json: "code", js: "code", typ: u(undefined, 0) },
    { json: "message", js: "message", typ: u(undefined, "") },
    { json: "data", js: "data", typ: u(undefined, r("Data")) },
    { json: "request_id", js: "request_id", typ: u(undefined, "") },
  ], false),
  "Data": o([
    { json: "topic_info", js: "topic_info", typ: u(undefined, r("TopicInfo")) },
    { json: "code", js: "code", typ: u(undefined, 0) },
  ], false),
  "TopicInfo": o([
    { json: "id", js: "id", typ: u(undefined, 0) },
    { json: "cover_image_url", js: "cover_image_url", typ: u(undefined, "") },
    { json: "vertical_image_url", js: "vertical_image_url", typ: u(undefined, "") },
    { json: "title", js: "title", typ: u(undefined, "") },
    { json: "description", js: "description", typ: u(undefined, "") },
    { json: "likes_count", js: "likes_count", typ: u(undefined, "") },
    { json: "origin_likes_count", js: "origin_likes_count", typ: u(undefined, 0) },
    { json: "comments_count", js: "comments_count", typ: u(undefined, "") },
    { json: "origin_comments_count", js: "origin_comments_count", typ: u(undefined, 0) },
    { json: "popularity_info", js: "popularity_info", typ: u(undefined, "") },
    { json: "fav_count", js: "fav_count", typ: u(undefined, "") },
    { json: "comics_count", js: "comics_count", typ: u(undefined, 0) },
    { json: "comic_body_count", js: "comic_body_count", typ: u(undefined, 0) },
    { json: "tags", js: "tags", typ: u(undefined, a("")) },
    { json: "comics", js: "comics", typ: u(undefined, a(r("Comic"))) },
    { json: "first_comic_id", js: "first_comic_id", typ: u(undefined, 0) },
    { json: "user", js: "user", typ: u(undefined, r("User")) },
    { json: "signing_status", js: "signing_status", typ: u(undefined, "") },
    { json: "is_free", js: "is_free", typ: u(undefined, true) },
    { json: "update_status", js: "update_status", typ: u(undefined, "") },
    { json: "is_favourite", js: "is_favourite", typ: u(undefined, true) },
  ], false),
  "Comic": o([
    { json: "id", js: "id", typ: u(undefined, 0) },
    { json: "title", js: "title", typ: u(undefined, "") },
    { json: "cover_image_url", js: "cover_image_url", typ: u(undefined, "") },
    { json: "is_pay_comic", js: "is_pay_comic", typ: u(undefined, true) },
    { json: "need_vip", js: "need_vip", typ: u(undefined, true) },
    { json: "locked", js: "locked", typ: u(undefined, true) },
    { json: "locked_code", js: "locked_code", typ: u(undefined, 0) },
    { json: "likes_count", js: "likes_count", typ: u(undefined, "") },
    { json: "likes_count_number", js: "likes_count_number", typ: u(undefined, 0) },
    { json: "created_at", js: "created_at", typ: u(undefined, r("CreatedAt")) },
    { json: "is_free", js: "is_free", typ: u(undefined, true) },
    { json: "is_vip_exclusive", js: "is_vip_exclusive", typ: u(undefined, true) },
    { json: "vip_exclusive_type", js: "vip_exclusive_type", typ: u(undefined, 0) },
    { json: "vip_time_free_type", js: "vip_time_free_type", typ: u(undefined, 0) },
  ], false),
  "User": o([
    { json: "user_id", js: "user_id", typ: u(undefined, 0) },
    { json: "nickname", js: "nickname", typ: u(undefined, "") },
    { json: "avatar", js: "avatar", typ: u(undefined, "") },
  ], false),
  "CreatedAt": [
    "06-27",
  ],
};
