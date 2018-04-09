CREATE TABLE ilks (
  id     integer primary key,
  spot   integer,
  rate   integer,
  line   decimal,
  art    decimal,
  time   timestamptz not null
);
