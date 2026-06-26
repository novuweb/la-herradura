-- Migración: añadir columna imagenes (array de URLs) a la tabla properties
-- Ejecutar en: Supabase > SQL Editor

ALTER TABLE properties
  ADD COLUMN IF NOT EXISTS imagenes text[] DEFAULT '{}';

-- Migrar datos existentes: si hay imagen_url, moverla al array imagenes
UPDATE properties
  SET imagenes = ARRAY[imagen_url]
  WHERE imagen_url IS NOT NULL AND (imagenes IS NULL OR array_length(imagenes, 1) IS NULL);
