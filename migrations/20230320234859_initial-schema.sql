-- Add migration script here --
create table if not exists "upstream_registry" (
    "id" bigint generated by default as identity primary key,
    "hostname" text not null,
    "path_prefix" text not null,
    constraint unique_hostname unique ("hostname")
);

insert into "upstream_registry" ("hostname", "path_prefix") values ('registry.terraform.io', 'v1/providers');

create table if not exists "terraform_provider" (
    "id" bigint generated by default as identity primary key,

    "version" text not null,
    "os" text not null,
    "arch" text not null,

    "registry_id" bigint references "upstream_registry" ("id"),
    "upstream_package_url" text,
    "sha256sum" text,

    constraint "version_tuple" unique ("version", "os", "arch")
);

