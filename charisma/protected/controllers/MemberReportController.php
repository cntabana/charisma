<?php

class MemberReportController extends Controller
{


	public function actionIndex()
	{
        $sql = "select count(*) num, case 
                when type = 0 then 'Student' 
                when type = 1 then 'Staff'
                else 'Pension' 
                end type
                 from members  group by type";
		$command = Yii::app()->db->createCommand($sql);         
	    $results = $command->queryAll();      
       
        $lcv = 0;
        $sex = array();
        $counts = array();
        foreach ($results as $result)
        {
            $sex[$lcv] = $result['type'];
            $counts[] = (int)$result['num'];
            $lcv++;
        }
        
        $this->render('index', array('data'=>$sex, 'num'=>$counts, 'title'=>'Type of Members'));    
	}
	
	public function actionReportbyGender()
	{
        $sql = "select count(*) num,case when sex = 0 then 'Male'
                                         when sex = 1 then 'Female'
                                    else ''
                                    end Gender from members  group by sex";
		$command = Yii::app()->db->createCommand($sql);         
	    $results = $command->queryAll();      
       
        $lcv = 0;
        $district = array();
        $counts = array();
        foreach ($results as $result)
        {
            $district[$lcv] = $result['Gender'];
            $counts[] = (int)$result['num'];
            $lcv++;
        }
        
        $this->render('index', array('data'=>$district, 'num'=>$counts, 'title'=>'Gender'));    
	}

	public function actionReportbyAges()
	{
        $sql = "select count(*) num,sex Gender from members  group by sex";
		$command = Yii::app()->db->createCommand($sql);         
	    $results = $command->queryAll();      
       
        $lcv = 0;
        $district = array();
        $counts = array();
        foreach ($results as $result)
        {
            $district[$lcv] = $result['Gender'];
            $counts[] = (int)$result['num'];
            $lcv++;
        }
        
        $this->render('index', array('data'=>$district, 'num'=>$counts, 'title'=>'Ages'));    
	}
	}