SELECT
    id,
    title,
    title_slug,
    author,
    lead_paragraph,
    text_body,
    text_type AS "text_type!: TextType",
    created_at,
    updated_at,
    tags,
    is_published,
    creators AS "creator!: Creator"
FROM
    articles
JOIN creators ON
    articles.author = creators.username
WHERE
    to_tsquery(FORMAT('%s', ARRAY_TO_STRING(STRING_TO_ARRAY($1, ' '), ' & '))) @@ search_vec AND is_published = true
