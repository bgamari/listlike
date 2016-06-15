{-# LANGUAGE Safe #-}
{-# LANGUAGE MultiParamTypeClasses
            ,FlexibleInstances #-}

module Data.ListLike.Text.Text

where

import           Prelude as P
import           Control.Monad
import qualified Data.Text as T
import qualified Data.Text.IO as TI
import           Data.Text.Encoding (decodeUtf8)
import           Data.ListLike.Base as LL
import           Data.ListLike.FoldableLL
import           Data.ListLike.IO
import           Data.ListLike.String

import qualified Data.ByteString as BS

instance FoldableLL T.Text Char where
    foldl = T.foldl
    foldl' = T.foldl'
    foldl1 = T.foldl1
    foldr = T.foldr
    --foldr' = T.foldr'
    foldr1 = T.foldr1

instance ListLike T.Text Char where
    empty = T.empty
    singleton = T.singleton
    cons = T.cons
    snoc = T.snoc
    append = T.append
    head = T.head
    last = T.last
    tail = T.tail
    init = T.init
    null = T.null
    length = T.length
    rigidMap = T.map
    reverse = T.reverse
    intersperse = T.intersperse
    concat = T.concat . toList
    rigidConcatMap = T.concatMap
    any = T.any
    all = T.all
    maximum = T.maximum
    minimum = T.minimum
    replicate n = T.replicate n . T.singleton
    take = T.take
    drop = T.drop
    splitAt = T.splitAt
    takeWhile = T.takeWhile
    dropWhile = T.dropWhile
    span = T.span
    break = T.break
    group = fromList . T.group
    inits = fromList . T.inits
    tails = fromList . T.tails
    isPrefixOf = T.isPrefixOf
    isSuffixOf = T.isSuffixOf
    elem = T.isInfixOf . T.singleton
    find = T.find
    filter = T.filter
    index = T.index
    findIndex = T.findIndex
    toList = T.unpack
    fromList = T.pack
    fromListLike = fromList . toList
    groupBy f = fromList . T.groupBy f
    genericLength = fromInteger . fromIntegral . T.length
    genericTake i = T.take (fromIntegral i)
    genericDrop i = T.drop (fromIntegral i)
    genericSplitAt i = T.splitAt (fromIntegral i)
    genericReplicate i = LL.replicate (fromIntegral i)

    sequence  = liftM fromList . P.sequence  . toList
    mapM func = liftM fromList . P.mapM func . toList

instance ListLikeIO T.Text Char where
    hGetLine = TI.hGetLine
    hGetContents = TI.hGetContents
    hGet h c = BS.hGet h c >>= return . decodeUtf8
    hGetNonBlocking h i = BS.hGetNonBlocking h i >>= return . decodeUtf8
    hPutStr = TI.hPutStr
    hPutStrLn = TI.hPutStrLn
    getLine = TI.getLine
    getContents = TI.getContents
    putStr = TI.putStr
    putStrLn = TI.putStrLn
    interact = TI.interact
    readFile = TI.readFile
    writeFile = TI.writeFile
    appendFile = TI.appendFile

instance StringLike T.Text where
    toString = T.unpack
    fromString = T.pack
    words = fromList . T.words
    lines = fromList . T.lines
    unwords = T.unwords . toList
    unlines = T.unlines . toList
