//
//  DBAccess.swift
//
//
//  Created by KOBAYASHI JUN on 2017/05/19.
//  Copyright © 2017年 KOBAYASHI JUN. All rights reserved.
//

import Foundation

// MARK:- DB関連 / FMDB 

// let dbVersion = ("20170411")
let dbVersion = ("20170514")


class DBAccess {
    static func setSqlite(){
        LOG_METHOD()
        
        // /Libraryまでのパスを取得
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory,.userDomainMask, true)
        // <Application>/Library/*******.db というパスを生成
        let libPath = (paths[0] as NSString).appendingPathComponent(dbVersion + ".db")
        LOG(msg:"Libpath: \(libPath)")
        
        
        // ファイルマネージャーのインスタンス確保
        let fm = FileManager()
        if fm.fileExists(atPath: libPath) == false {
            //ファイルがない場合はコピー
            let dbPath = Bundle.main.path(forResource: dbVersion, ofType: "db")
            LOG(msg:"DBpath: \(dbPath)")
            
            do{
                try fm.copyItem(atPath: dbPath!, toPath: libPath)
            } catch let error as NSError {
                // エラー情報を出力する
                LOG(msg: error)
            }
            
            
            if fm.fileExists(atPath: libPath) == false {
                //error
                LOG(msg:"DB file Copy error bunlde --> library")
            }
        }else{
            LOG(msg:"DB file OK")
        }
    }

}
