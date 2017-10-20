package cq;

import java.sql.*;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.ServerSocket;
import java.net.Socket;

public class server {    
    
    public static void main(String args[]) throws IOException {    
        
       int port = 8999;    
       
       //定义一个ServerSocket监听在端口8999上    
       ServerSocket server = new ServerSocket(port);    
       //server尝试接收其他Socket的连接请求，server的accept方法是阻塞式的   
       
       
       while(true){
    	   Socket socket = server.accept();
    	   System.out.println("lessoning");
       //跟客户端建立好连接之后，我们就可以获取socket的InputStream，并从中读取客户端发过来的信息了。    
    	   new Thread(new Task(socket)).start();
           //Writer writer = new OutputStreamWriter(socket.getOutputStream());
       }
    }
       
       static class Task implements Runnable {
    	   private Socket socket;
    	   
    	   public Task(Socket socket) {
    		   this.socket=socket;
    	   }
    	   
    	   public void run() {
    		   
    		   try {
    			   handleSocket();
    		   } catch (Exception e) {
    			   e.printStackTrace();
    		   }
    	   }
    
    	   
       private void handleSocket() throws Exception {
    	   Reader reader = new InputStreamReader(socket.getInputStream());
    	   Writer writer = new OutputStreamWriter(socket.getOutputStream());
    	   String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
           String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=CS526demo";
           String userName="sa";
           String userPwd="qc476404667";
           Connection ct = null;
           try
           {
            Class.forName(driverName);
            ct=DriverManager.getConnection(dbURL,userName,userPwd);
             System.out.println("连接数据库成功");
           }
           catch(Exception e)
           {
            e.printStackTrace();
           // System.out.print("连接失败");
           }
       while(true){
       char chars[] = new char[64];    
       int len;
       String temp;
       int index;
       StringBuilder sb = new StringBuilder(); 
       while ((len=reader.read(chars)) != -1) { 
    	   
    	   temp=new String(chars,0,len);
    	   if((index = temp.indexOf("&"))!= -1){
    		   sb.append(temp.substring(0, index));
    		   break;
    	   }
          sb.append(new String(chars, 0, len)); 
          
       } 
       if(len==-1) break;
       char phone[] = new char [30];
       sb.getChars(0,30,phone,0);
       String func = new String(phone,0,1);
       
       if(func.equals("2")){
    	   String area = new String(phone,1,1);
    	   System.out.println("the user is in area "+area);
       }
       else {
       String id = new String(phone,2,9);
       System.out.println("received information from "+id);
       String l = new String(phone,11,9);
       String h = new String(phone,21,9);
       double latitude;
       double longitude;
       latitude=Double.parseDouble(l);
       longitude=Double.parseDouble(h);
       double[][] loca = new double[9][2];     //商店的坐标
       String [][] shopname = new String[9][2];
       int [][] spid=new int[9][2];
       initschool(shopname,loca,spid);
      // initmall(shopname,loca,spid);
       int [] shop = new int[10];
       float [][] perference = new float[10][3];
       String [] shopid = new String[20] ;
       
       
       int i;
       double distan2 = 0.15;
       for(i=0;i<9;i++){                 
    	   double dis = GetDistance(latitude,longitude,loca[i][0],loca[i][1]);
    	  // System.out.println(dis);
    	   perference[i][1]=(float) ((perference[i][1]+20-Math.abs(dis-distan2))*100);
		   perference[i][2]=(float) ((perference[i][2]+20-Math.abs(dis-distan2))*100);
    	   if(dis<distan2){
    		   shop[i]=1;
    		   
    	   }
    	   
       }
       double min=GetDistance(latitude,longitude,loca[0][0],loca[0][1]);
       int hh=0;
       for(i=1;i<9;i++){
    	   double dis = GetDistance(latitude,longitude,loca[i][0],loca[i][1]);
    	   if(dis<min){
    		   min=dis;
    		   hh=i;
    	   }
       }
       //PreparedStatement vs=null;
       //ResultSet bs=null;
      // ResultSet ki = ct.executeUpdate("insert into school values('"+id+"','"+shopname[hh]+"','"+"1')");
      // vs=ct.prepareStatement("insert into school values('"+id+"','"+shopname[hh]+"','"+"2')");  
      // bs=vs.executeQuery();  
     //  System.out.println("user "+ id+" is near "+shopname[hh][0]);
      
       System.out.println("latitude " + latitude + "longitute" + longitude);   
       //从数据库里读数据
      
      for(i=0;i<10;i++){
    	 if(shop[i]==1){
    		   	    
            PreparedStatement ps=null;
            ResultSet rs=null;
            ps=ct.prepareStatement("Select * from school where id = " + id +"and localization ='" + shopname[i][0]+"'"+"and area ='1'");  
            rs=ps.executeQuery();  
            while(rs.next()){  
              perference[i][1]++;  
               
            }
            ps=ct.prepareStatement("Select * from school where id = " + id +"and localization ='" + shopname[i][1]+"'"+"and area ='2'");  
            rs=ps.executeQuery();  
            while(rs.next()){  
              perference[i][2]++;                
               
            }
    	 }
       
      }
      
      int area =0;
      int co=0;
      String [] shna=new String[20];
      
      for(i=0;i<9;i++){
    	  for(area=1;area<=2;area++){
    	
    	  float max = perference[i][area];
    	  shopid[co]=""+area;
    	  shna[co]=shopname[i][area-1];
    	  int t=0;
          int ar=0;
    	  int j;
    	  
    	  for(j=i;j<10;j++)
    	  {
    		  int e;
    		  for(e=area;e<=2;e++){
    		      if(perference[j][e]>max){
    			     max = perference[j][e];
    			     t =j;
    			     ar=e;
    		      }
    		  }
    	  }
    	  //System.out.println(" "+max+" "+t+" "+ar);
    	  if(ar!=0){
    		  float change;    		  
    		  String spname;
    		  change = perference[i][area];    		  
    		  spname = shopname[i][area-1];
    		  perference[i][area]=perference[t][ar];
    		  shopid[co]=""+spid[t][ar-1];
    		  shna[co]=shopname[t][ar-1];
    		  shopname[i][area-1]=shopname[t][ar-1];
    		  perference[t][ar]=change;    		  
    		  shopname[t][ar-1]=spname;
    		  co++;
    	  }
    	  else {
    		  
    		  co++;
    		  
    	  }
      }
      }
      
      //从数据库里读取商店信息
      
      String [] name = new String [3];
      String [] information = new String [3];
      name[0]=shna[0];
      int count =0;
      PreparedStatement ps=null;
      ResultSet rs=null;
	  ps=ct.prepareStatement("Select * from malls where name ='" + shna[0] +"'"+"and area ='"+shopid[0]+"'");  
      rs=ps.executeQuery();  
      
      while(rs.next()){  
    	information[0]=rs.getString(3)+"\n \n";
        information[0]=information[0]+rs.getString(4)+"\n \n";  
        information[0]=information[0]+rs.getString(5)+"\n \n";
      }
      for(i=1;i<7;i++){
    	  if(count==2) break;
    	  int kl=0;
          
    	  if(shna[i]==name[0]||shna[i]==name[1]){
    		  if(shna[i]==name[0]){
    		  ps=ct.prepareStatement("Select * from malls where name = '" + shna[i] + "'" +"and area ='"+shopid[i]+"'");  
    	      rs=ps.executeQuery();  
    	      while(rs.next()){  
    	    	information[0]=information[0]+rs.getString(3)+"\n \n";
    	        information[0]=information[0]+rs.getString(4)+"\n \n";  
    	        information[0]=information[0]+rs.getString(5)+"\n \n";
    	      }}
    		  else if(shna[i]==name[1]){
    			  ps=ct.prepareStatement("Select * from malls where name = '" + shna[i] + "'" +"and area ='"+shopid[i]+"'");  
        	      rs=ps.executeQuery();  
        	      while(rs.next()){  
        	    	information[1]=information[1]+rs.getString(3)+"\n \n";
        	        information[1]=information[1]+rs.getString(4)+"\n \n";  
        	        information[1]=information[1]+rs.getString(5)+"\n \n";
        	      }
    		  }
    	  }
    	  else{
    		  count++;
    		  name[count]=shna[i];
    		  ps=ct.prepareStatement("Select * from malls where name ='" + shna[i] +"'"+"and area ='"+shopid[i]+"'");  
    	      rs=ps.executeQuery();  
    	      while(rs.next()){  
    	    	information[count]=rs.getString(3)+"\n \n";
    	        information[count]=information[count]+rs.getString(4)+"\n \n";  
    	        information[count]=information[count]+rs.getString(5)+"\n \n";
    	      }
    	  }
    	  
      }
      
     
       //读完后写一句  
       
       writer.write(name[0]+"^"+information[0]+"&"+name[1]+"^"+information[1]+"&"+name[2]+"^"+information[2]);
       writer.flush();
           
            
      
       //System.out.println("send information back");
       }
       }
       writer.close();
       reader.close();
       socket.close();
      // System.out.println("terminal");
    }
       }
       
    static void initschool(String [][] shopname,double [][]loca,int [][] id){
    	shopname[0][0]="library";
    	shopname[0][1]="library";
    	id[0][0]=0;
    	id[0][1]=1;
    	loca[0][0]=42.088457;
    	loca[0][1]=75.970117;
    	shopname[1][0]="student wings";
    	shopname[1][1]="student wings";
    	id[1][0]=0;
    	id[1][1]=1;
    	loca[1][0]=42.087155;
    	loca[1][1]=75.972262;
    	shopname[2][0]="university union";
    	shopname[2][1]="university union";
    	id[2][0]=0;
    	id[2][1]=1;
    	loca[2][0]=42.087155;
    	loca[2][1]=75.967352;
    	shopname[3][0]="art museum";
    	shopname[3][1]="art museum";
    	id[3][0]=0;
    	id[3][1]=1;
    	loca[3][0]=42.088739;
    	loca[3][1]=75.969030;
    	shopname[4][0]="Department of MS";
    	shopname[4][1]="Department of MS";
    	id[4][0]=0;
    	id[4][1]=1;
    	loca[4][0]=42.088225;
    	loca[4][1]=75.964323;
    	shopname[5][0]="newing college";
    	shopname[5][1]="newing college";
    	id[5][0]=0;
    	id[5][1]=1;
    	loca[5][0]=42.087195;
    	loca[5][1]=75.962858;
    	shopname[6][0]="dickinson";
    	shopname[6][1]="dickinson";
    	id[6][0]=0;
    	id[6][1]=1;
    	loca[6][0]=42.086385;
    	loca[6][1]=75.965065;
    	shopname[7][0]="science library";
    	shopname[7][1]="science library";
    	id[7][0]=0;
    	id[7][1]=1;
    	loca[7][0]=42.089484;
    	loca[7][1]=75.972136;
    	shopname[8][0]="lot area";
    	shopname[8][1]="lot area";
    	id[8][0]=0;
    	id[8][1]=1;
    	loca[8][0]=42.090840;
    	loca[8][1]=75.973202;
    }
    
    static void initmall(String [][] shopname,double [][]loca,int [][] id){
    	shopname[0][0]="Walmart";
    	shopname[0][1]="Walmart";
    	id[0][0]=1;
    	id[0][1]=2;
    	loca[0][0]=42.095462;
    	loca[0][1]=76.013498;
    	shopname[1][0]="AMC";
    	shopname[1][1]="AMC";
    	id[1][0]=1;
    	id[1][1]=2;
    	loca[1][0]=42.097679;
    	loca[1][1]=76.010639;
    	shopname[2][0]="A.C.Moore";
    	shopname[2][1]="A.C.Moore";
    	id[2][0]=1;
    	id[2][1]=2;
    	loca[2][0]=42.098119;
    	loca[2][1]=76.009639;
    	shopname[3][0]="T.J.Maxx";
    	shopname[3][1]="T.J.Maxx";
    	id[3][0]=1;
    	id[3][1]=2;
    	loca[3][0]=42.096783;
    	loca[3][1]=76.012527;
    	shopname[4][0]="Sams Club";
    	shopname[4][1]="Sams Club";
    	id[4][0]=1;
    	id[4][1]=2;
    	loca[4][0]=42.098548;
    	loca[4][1]=76.007574;
    	shopname[5][0]="TGI Fridats";
    	shopname[5][1]="TGI Fridats";
    	id[5][0]=1;
    	id[5][1]=2;
    	loca[5][0]=42.095620;
    	loca[5][1]=76.010662;
    	shopname[6][0]="sweetFrog";
    	shopname[6][1]="sweetFrog";
    	id[6][0]=1;
    	id[6][1]=2;
    	loca[6][0]=42.097272;
    	loca[6][1]=76.011338;
    	shopname[7][0]="Dicks Sporting";
    	shopname[7][1]="Dicks Sporting";
    	id[7][0]=1;
    	id[7][1]=2;
    	loca[7][0]=42.098356;
    	loca[7][1]=76.008780;
    	shopname[8][0]="Barnes Noble";
    	shopname[8][1]="Barnes Noble";
    	id[8][0]=1;
    	id[8][1]=2;
    	loca[8][0]=42.096608;
    	loca[8][1]=76.007498;
    }
    
    static double GetDistance(double lat1, double lng1, double lat2, double lng2)
    {
    	if(Math.abs(lat1)>90||Math.abs(lat2)>90)
    		return -1;
    	if(Math.abs(lng1)>180||Math.abs(lng2)>180)
    		return -1;
    	double radLat1 = ((lat1*Math.PI)/180.0);
    	double radLat2 = ((lat2*Math.PI)/180.0);
    	double a=radLat1 - radLat2;
    	double radLng1 = ((lng1*Math.PI)/180.0);
    	double radLng2 = ((lng2*Math.PI)/180.0);
    	double b = radLng1 - radLng2;
    	double s = 2*Math.asin(Math.sqrt(Math.pow(Math.sin(a/2), 2) + Math.cos(radLng1)*Math.cos(radLng2)
*Math.pow(Math.sin(b/2), 2)));
    	
    	s = s * 6378.137;
    	    	
    	return s;
    }
    
    
}