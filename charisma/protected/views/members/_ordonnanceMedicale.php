
<?php
$hospital = '';
if(isset(Yii::app()->session['iduser'])){

 $hospital = Yii::app()->db->createCommand()
    ->select('hopitalName')
    ->from('hospital')
    ->where('iduser=:id', array(':id'=>Yii::app()->session['iduser']))
    ->queryScalar();
}
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/admin'), 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/index'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
		array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/formulaire',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/ordonnanceMedicale',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
    array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/lunette',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/analyseDemande',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

		),
));
$this->endWidget();


$birthday_timestamp = strtotime($data->birthday);  
// Calculates age correctly
// Just need birthday in timestamp
$age = date('md', $birthday_timestamp) > date('md') ? date('Y') - date('Y', $birthday_timestamp) - 1 : date('Y') - date('Y', $birthday_timestamp);
  ?>
</hr>
<div class='printableArea'>
<table width="80%" align='center' border=0>
	<tr> 
		 <td>
          <p>
            University of Rwanda Medical Insurance Scheme<br/>
            Mutuelle de Sante de l'Universite du Rwanda<br/>
            B.P. HI-TEL: 531031<br/>
            HUYE
          </p>
		 </td>
	</tr>

	<tr> 
		 <td colspan=3> <h2>
		 	<center>Ordonnance Medicale N° </center>
		 </h2></td>
	</tr>

	<tr> 
		 <td><h4>Identification</h4></br></td>
	</tr>

	<tr> 
		 <td>
            <ul>
              <li>Hopital de : : <b><?php echo $hospital;?><b></li>
              <li>Nom du Malade <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li></b>
              <li>
                Age :<b><?php echo $age; ?> ans
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Gender :<b><?php if($data->sex == 0) echo "Male";else echo "Female"; ?>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </li></b>
              <li>Nom du membre principal : <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li></b></li>
              <li>Numero de la carte : <?php echo CHtml::encode($data->cardnumber); ?>
              <li>Date d' admission: : <b><?php echo date('d-m.Y');?><b></li>
              <li>Beneficiaire : <?php echo "Adherent lui-meme"; ?></li>
              <li>Service de :</li>
            </ul>
		 </td>
	</tr>
<tr><td colspan=3><center><h3>Prescription</h3></center> </td></tr>
	<tr> 
		 <td colspan=3>
            <table border=1 width=100%> 
               
               <tr >
               	<td colspan=3><center>STRICTEMENT RESERVE AU MEDECIN</center></td>
               </tr>
               <tr height="200px">
               	<td colspan=3>&nbsp;</td>
              
               </tr>
               <tr >
               	<td >CoutTotal:</td>
               	 <td colspan=2>&nbsp;</td>
               	</tr>
                <tr >
               	<td>15%</td>
               	 <td colspan=2>Fait a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le </td>
               	</tr>
                <tr>
               	<td>85%</td>
               	 <td colspan=2>Nom du medecin</td>
               	</tr>
            </table>
		 </td>
	</tr>

    <tr>
         <td colspan=2 align='right'><br/></br>Signature et Cachet</td>
          
<table>

</div>
<style type="text/css" media="print">
body {visibility:hidden;}
.printableArea{visibility:visible;} 
</style>
<script type="text/javascript">
function printDiv()
{

window.print();

}
</script>


