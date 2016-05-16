using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Windows;
   public class AssemblyLoader
    {      
           public static Assembly AssemblyResolve(ResolveEventArgs args)
           {
               Assembly asem = null;

               string FrameworkfilePath = @"../../Frameworks/" + args.Name.Split(',')[0] + ".dll";// relative path 
               string ModulesfilePath = @"../../Modules/" + args.Name.Split(',')[0] + ".dll";// relative path 
               string ThirdpartyfilePath = @"../../Thirdparty/" + args.Name.Split(',')[0] + ".dll";// relative path 

               if (File.Exists(FrameworkfilePath))
               {
                   asem = Assembly.LoadFrom(FrameworkfilePath);
               }
               else if (File.Exists(ModulesfilePath))
               {
                   asem = Assembly.LoadFrom(ModulesfilePath);
               }
               else if (File.Exists(ThirdpartyfilePath))
               {
                   asem = Assembly.LoadFrom(ThirdpartyfilePath);
               }              
               return asem;
               
           }

           public static void AssemblyResolve()
           {
               if (AppDomain.CurrentDomain.BaseDirectory != null)
                   Directory.SetCurrentDirectory(AppDomain.CurrentDomain.BaseDirectory);
               AppDomain.CurrentDomain.AssemblyResolve += new ResolveEventHandler(CurrentDomain_AssemblyResolve);
           }

           static Assembly CurrentDomain_AssemblyResolve(object sender, ResolveEventArgs args)
           {
               return AssemblyResolve(args);
           }
       }
    

